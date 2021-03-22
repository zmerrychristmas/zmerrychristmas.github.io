---
title: Tạo Rails API với Grape
categories:
- Framework
- Rails
- api
- grape
tags:
- rails
- api
- grape
---

Trong việc module hóa cũng như tạo cấu trúc REST API bạn có thể tự tạo cho mình một framework riêng hoặc sử dụng một framework đã có và đang được phát triển và ưa dùng là [grape](http://www.ruby-grape.org/). tham khảo tại [đây](https://github.com/ruby-grape/grape) 
# Grape api là gì ?
``Grape is a REST-like API framework for Ruby. It's designed to run on Rack or complement existing web application frameworks such as Rails and Sinatra by providing a simple DSL to easily develop RESTful APIs. It has built-in support for common conventions, including multiple formats, subdomain/prefix restriction, content negotiation, versioning and much more.``
* api frame work
* Restful Apis
* Rack, Sinatra support 
* built-in support  

Nói gọn lại là Grape là một framework tích hợp và ăn nhập với các server như rack, sinsatra để tạo ra hệ thống Restful APIs. Ưu điểm là nó rất nhanh hơn các `rails-api` thông thường.
Trong bài này tôi sẽ giới thiệu và demo một ứng dụng sử dụng grape api.
Với mong muốn đi sâu hơn vào grape và ứng dụng của grape với rails nên tôi sẽ có thể viết nối tiếp một số bài nữa.
# Cài đặt
Trong gemfile 
```
gem 'grape'
```
Run bundle : ``` bundle update ```

## Controller example 
```ruby
module Twitter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    helpers do
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    resource :statuses do
      desc 'Return a public timeline.'
      get :public_timeline do
        Status.limit(20)
      end

      desc 'Return a personal timeline.'
      get :home_timeline do
        authenticate!
        current_user.statuses.limit(20)
      end

      desc 'Return a status.'
      params do
        requires :id, type: Integer, desc: 'Status ID.'
      end
      route_param :id do
        get do
          Status.find(params[:id])
        end
      end

      desc 'Create a status.'
      params do
        requires :status, type: String, desc: 'Your status.'
      end
      post do
        authenticate!
        Status.create!({
          user: current_user,
          text: params[:status]
        })
      end

      desc 'Update a status.'
      params do
        requires :id, type: String, desc: 'Status ID.'
        requires :status, type: String, desc: 'Your status.'
      end
      put ':id' do
        authenticate!
        current_user.statuses.find(params[:id]).update({
          user: current_user,
          text: params[:status]
        })
      end

      desc 'Delete a status.'
      params do
        requires :id, type: String, desc: 'Status ID.'
      end
      delete ':id' do
        authenticate!
        current_user.statuses.find(params[:id]).destroy
      end
    end
  end
end
```
## Cấu trúc thư mục 
1. sơ cấp
```
app
 |––controllers
       |––api
```
2. mount một file `base.rb`
```ruby 
module API  
  class Base < Grape::API
			mount API::V1::Base
  end
end  
```
cấu trúc thư mục 
```
app
 |––controllers
       |––api
           |––base.rb
```  

# Khái niệm cơ bản
## **mount**
**mount**:  là cơ chế nói cho rails biết là grape đang tạo ra số lượng api tương ứng với file 
```ruby
Twitter::API.compile!
```
Đối với rails để mount một file và tạo ra routes ta cần làm như sau:
- rails < 5.2
sửa lại file ``application.rb``
```ruby
config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
```
- rails 
thêm vào file ``config/routes.rb``
```ruby
mount Twitter::API => '/'
```
- rails 6.0 sửa file ``config/initializers/inflections.rb``
```ruby
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end
```
Trong việc mount là một cơ chế kỳ ảo của grape đảm bảo việc nested và mở rộng module hóa cũng quản lý version.  

## **version**
Từ **version** 1 bạn có thể phát triển lên version 2, 3. Grape dễ dàng quản lý điều đó dựa trên các câu lệnh cùng thư mục 
```
app
 |––controllers
       |––api
           |––base.rb
           |––v1
               |––base.rb
```
Các khái niệm cơ bản:
There are four strategies in which clients can reach your API's endpoints: `:path, :header, :accept_version_header and :param`. The default strategy is :path.
1. path 
``` version 'v1', using: :path ```  
	use with curl: ``` curl http://localhost:9292/v1/statuses/public_timeline ```
2. header
``` 
	version 'v1', using: :header, vendor: 'twitter'
```
 use with curl:
 ```
 curl -H Accept:application/vnd.twitter-v1+json http://localhost:9292/statuses/public_timeline
 ```
3. accept_version_header
```
version 'v1', using: :accept_version_header
```
example: ```
curl -H "Accept-Version:v1" http://localhost:9292/statuses/public_timeline
```
4. param
```
version 'v1', using: :param, parameter: 'v'
```
ex: ```
curl http://localhost:9292/statuses/public_timeline?v=v1
```

## **version, mount, nested**
Giả sử bạn cần mở rộng module v1 bằng việc khải báo thêm các api.
bước 1: Tạo folder v1
```
app
 |––controllers
       |––api
           |––base.rb
           |––v1
```
bước 2:  với mỗi version tạo một `base.rb` riêng: 
```
app
 |––controllers
       |––api
           |––base.rb
           |––v1
               |––base.rb
```
bước 3: Trong file base khai báo mount thư mục đồng cấp 
```ruby
module API
  module V1
    class Base < Grape::API
      mount V1::Users
      # mount API::V1::AnotherResource
    end
  end
end
```
bước 4: khai báo api tương ứng `user.rb`
```
app
 |––controllers
       |––api
           |––base.rb
           |––v1
               |––base.rb
               |––users.rb
```
## **api end point**
Như ở trên khi bạn khai báo 1 api đồng cấp, đó cũng là api end point.
Đối với một api end point:
```ruby
module API  
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "user" do
          User.where(id: params[:user_id]).first
        end
      end
    end
  end
end  
```
`resource`: khai báo router 
`desc`: mô tả 
`` get "", root: :users do`` khai báo url api lấy toàn bộ user
ex: ``` http://localhost:3000/api/v1/users ```
tool: **POSTMAN**

# Action, Helper 
## Mixin, format dữ liệu, các hàm dùng chung 
được khai báo tại file `defaults.rb`, ex: `app/controllers/api/v1/defaults.rb`
- khai báo định dạng output như json
- các hàm như authencation.  
```ruby
module API  
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, 
             Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, 
               include_missing: false)
          end

          def logger
            Rails.logger
          end
        end
        
        # check authentice_user
        def authenticate_user!
            uid = request.headers["Uid"]
            token = request.headers["Access-Token"]
            @current_user = User.find_by(uid: uid)
            unless @current_user && @current_user.valid_token?(token)
              api_error!("You need to log in to use the app.", "failure", 401, {})
            end
          end
		
        # Hàm hiển thị errors message khi lỗi
        def api_error!(message, error_code, status, header)
           error!({message: message, code: error_code}, status, header)
        end
        
        #  # Hàm raise errors message khi lỗi
        def api_error_log(message)
            @logger ||= Logger.new(ProjectLogger.log_path("project_api"))
            @logger.info("=============#{Time.zone.now.to_s}==================\n")
            @logger.info("#{message}\n")
         end
          
        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
        
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error_response(message: e.message, status: 400)
        end
        
      end
    end
  end
end
```

## Action callback 
Grape vấn support đầy đủ các hàm call back như:  
	1. before  
	2. before_validation  
	3. validations  
	4. after_validation  
	5. the API call  
	6. after
	7. finally

Example: 
```ruby 
class MyAPI < Grape::API
  get '/' do
    "root - #{@blah}"
  end

  namespace :foo do
    before do
      @blah = 'blah'
    end

    get '/' do
      "root - foo - #{@blah}"
    end

    namespace :bar do
      get '/' do
        "root - foo - bar - #{@blah}"
      end
    end
  end
end
```
kết quả 
```
GET /           # 'root - '
GET /foo        # 'root - foo - blah'
GET /foo/bar    # 'root - foo - bar - blah'
```
example version
```ruby
class Test < Grape::API
  resource :foo do
    version 'v1', :using => :path do
      before do
        @output ||= 'v1-'
      end
      get '/' do
        @output += 'hello'
      end
    end

    version 'v2', :using => :path do
      before do
        @output ||= 'v2-'
      end
      get '/' do
        @output += 'hello'
      end
    end
  end
end
```
kết quả
``` 
GET /foo/v1       # 'v1-hello'
GET /foo/v2       # 'v2-hello'
```
## Rspec 
Viết rồi kiểm thử làm sao ?
-> viết rspec cho api ta có thể dùng gem [airborne](https://github.com/brooklynDev/airborne).
install: 
```
gem install airborne
```
cấu trúc thư mục 
```
spec
 |––api
       |––v1
           |––users_spec
```
nội dung file test:
```ruby
require "rails_helper"
require "airborne"

describe "API::V1::Users" do
  after(:all){I18n.locale = :ja}
  describe "POST api/v1/users" do
    let!(:user) do
      FactoryGirl.create :user, id: 1, email: "test@gmail.com", first_name: "James",
        last_name: "Bond", provider: "email"
    end

    context "when user update successfully" do
      let(:api_response){FactoryGirl.build(:api_update_user_success_response).deep_symbolize_keys}

      before do
        post("/api/v1/users", {first_name: "hitorri"},
          {"Accept-Language": "en", "App-Version": "knt/1.0", "Uid": user.uid, "Access-Token": user.access_token})
      end

      it{expect_json(api_response)}
    end
  end
 end

```
## CORS
using gem `rack-cors`, cấu hình tại file `config.ru`

```ruby
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

run Twitter::API
```
## Serializing
Công việc của chúng ta là convert mảng sang JSON. Để làm được việc này chúng ta cài thêm gem `grape-active_model_serializers`
```ruby
module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, 
             Grape::Formatter::ActiveModelSerializers
         ...
```
### Viết file serializers 
Create a directory, `serializers`, in the top level of your app. Create a `graduate_serializer.rb` file in that directory. Here is where our serializer will live.
``app/serializers/graduate_serializer.rb``
```ruby
class GraduateSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :cohort, 
       :current_job, :bio, :news, :website, :picture, 
       :created_at, :updated_at
end
```
# Grape Gem addition
## Grape Swagger
1. Add gem 'grape-swagger' to your Gemfile and `bundle install`.
2. Add grape-swagger documentation to the root or base class of your API.
tại file ``app/controllers/api/v1/base.rb`` thêm đoạn sau:
```ruby
require "grape-swagger"
			...
      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
```
3. Add the documentation endpoint to your routes.
tại file `config/routes.rb`:
```ruby
mount GrapeSwaggerRails::Engine, at: "/documentation"
```
vào url: `http://localhost/documentation` bạn sẽ redirect tới: `http://localhost:3000/api/v1/swagger_doc`

## Grape Entity
Có thể tham khảo thêm tại đây 
## Grape Logger 
Có thể tham khảo tại đây 
## Grape Swagger representable
Có thể tham khảo thêm tại đây 
# Tài liệu tham khảo
1. https://viblo.asia/p/xay-dung-api-voi-grape-bWrZne1vKxw
2. https://www.thegreatcodeadventure.com/making-a-rails-api-with-grap/
3. https://github.com/ruby-grape/grape#what-is-grape
