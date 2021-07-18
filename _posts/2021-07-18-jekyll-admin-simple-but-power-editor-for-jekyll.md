---
title: Trình soạn thảo cho jekyll
categories:
- Blogging
- Tutorial
tags:
- jekyll
- rails
- bugs
---

# Jekyll admin editor 
[Jekyll admin](https://github.com/jekyll/jekyll-admin) được cung cấp bới Opensource, với hệ thống support khá khiêm tốn hiện tại jekyll-admin đang dừng lại version 0.11.0 nhưng nếu chỉ là khiếm tốn thì tôi sẽ không giới thiệu với các bạn. 
Nếu bạn đã sử dụng [jekyll](https://jekyllrb.com/), một loại blog cá nhân được viết bằng markdown, tôi cũng đã giới thiệu trong một số bài viết trước đó.
### Jekyll admin là gì ? 
như tiêu đề của bài viết :hehe 
## Ưu điểm 
* Đơn giản
* Dễ sử dụng 
* Ngắn gọn 
* markdown support 
* Configuration support 
* Trình quản lý jekyll khá ổn .. mà vẫn thiếu thiếu, chả hiểu tại sao 
* Hoàn thiện tốt với jekyll 
* Cung cấp thẻ tags và thẻ categories(dùng làm menus)
* Giao diện khoa học 

## Nhược điểm 
Do là một trang web quản lý nội dung bài việt của jekyll, nó không thể tránh khỏi những nhược điểm:
Đơn giản 
Nhiều lỗi được báo không chính xác(còn tôi thì đoán chính xác là do ông nào try catch rồi vứt cái locale.yml ...)
Phiên bản hiện nay của jekyll-admin là 0.11.0 cũng đã lâu rồi so với jekyll, và với mỗi lần bạn update jekyll có thể sẽ gặp lỗi. \\Trong bài viết, tôi sẽ đề cập tới một lỗi
- ruby 2.4.0
- jekyll 4.2.0
- jekyll-admin 0.11.0

### Lỗi jekyll admin  server cannot init configuration 
bạn fix thế này nhé,
- bước 1: chọn 1 editor, chọn vào thư mục .rvm hoặc rbenv nếu rbenv là trình quản lý ruby, chọn vào thư mục gems/lib/jekell-admin/server.rb 
- bước 2: function *configuration* bạn chịnh sửa nội dung như sau: \\
```ruby
      # Computed configuration, with updates and defaults
      # Returns an instance of Jekyll::Configuration
      def configuration
        @configuration ||= site.config.merge(overrides)
        if @configuration.is_a?(Hash)
          @configuration = @configuration.each_with_object(Jekyll::Configuration.new) { |(k, v), hsh| hsh[k] = v }
        end
      end
```
- bước 3: nếu bạn bảo sao tự dưng lại lỗi, ừ thì do phiên bản ruby ^^!
