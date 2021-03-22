---
title: Cài đặt môi trường Ruby on Rails trên ubuntu 20.04
categories:
- Framework
- Rails
tags:
- rails
- git
- postgresql
- mysql
---

# Cài đặt môi trường Ruby on Rails trên ubuntu 
## Cài đặt truyền thống Ruby
Để cài đặt môi trường code ruby trên ubuntu rất đơn giản vì mặc định ubuntu đã cài đặt sẵn ruby theo từng phiên bản của ubuntu.  
```bash
ruby -v
```
Tuy nhiên đa số phiên bản ruby này là ruby core để chạy các ứng dụng và chương trình của linux nên không thuận tiện cho chúng ta. Cài đặt lại ruby tại [trang](https://gorails.com/setup/ubuntu/20.04) 
```bash
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
```
## Cài đặt qua công cụ quản lý Ruby 
Việc sử dụng công cụ quản lý rails giúp ta dễ dàng chuyển đổi qua các phiên bản rails theo từng dự án cài đặt tương ứng với một phiên bản ruby cần sử dụng,
Thông thường file ``.ruby-version`` sẽ cho biết phiên bản ruby và nếu cài đặt công cụ quản lý ruby sẽ tự động cài đặt như ta mong muốn.
### 1. rbenv
cài đặt thông qua câu lệnh `rbenv` 
```sh
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 3.0.0
rbenv global 3.0.0
ruby -v
```
### 2. rvm
`rvm` cũng tương tự nhưng khác câu lệnh với `rbenv`
```sh
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 3.0.0
rvm use 3.0.0 --default
ruby -v
```
## Cài đặt Rails 
```sh
gem install rails -v 6.1.1
```
Đối với rbenv, cần `rehash` lại 
```sh
rbenv rehash
```
Kiểm tra lại rails với 
```
rails -v
```
cài đặt bundler 
```sh
gem install bundler
```
## Cài đặt Database 
### Postgressql 
bước 1: cài đặt thư viện 
```
sudo apt install postgresql-11 libpq-dev
```
bước 2:  cài đặt password 
```sh
sudo -u postgres createuser zmerrychristmas -s
# If you would like to set a password for the user, you can do the following
sudo -u postgres psql
postgres=# \password 123456
```
### Mysql
```sh
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```
## Cài đặt Git 
```
sudo apt-get install git
```
Cấu hình git 
```sh
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t rsa -b 4096 -C "YOUR@EMAIL.com"
```
Cầu hình git với ssh-key 
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_rsa.pub
ssh -T git@github.com # test connection 
```

## Kiểm tra lại 
Tạo một project với rails 
```sh
#### If you want to use SQLite (not recommended)
rails new myapp

#### If you want to use MySQL
rails new myapp -d mysql

#### If you want to use Postgres
# Note that this will expect a postgres user with the same username
# as your app, you may need to edit config/database.yml to match the
# user you created earlier
rails new myapp -d postgresql

# Move into the application directory
cd myapp

# If you setup MySQL or Postgres with a username/password, modify the
# config/database.yml file to contain the username/password that you specified

# Create the database
rake db:create

rails server
```
