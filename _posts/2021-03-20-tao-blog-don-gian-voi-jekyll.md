---
title: Tạo Blog đơn giản với Github và Jekyll
categories:
- Blogging
- Tutorial
- Github
tags:
- github
- jekyll
---

# Xây dựng Blog cá nhân với Github và Jekyll
Đầu tiên nếu đối với mỗi ai trong chúng ta có niềm yêu thích muốn xây dựng cho mình một blog, blog đó là nơi để chia sẻ những kinh nghiệm đời sống và công việc cũng có thể là một kênh thông tin để truyền tải thông điệp và lưu giữ nhưng bài học của bạn trong hành trình cuộc sống không đơn giản này.
Tôi 30 tuổi và đang là một lập trình viên, tôi chưa gia đình, trong cuộc sống bộn bề và những suy nghĩ còn chưa đến đâu khi nhìn về tương lai và quá khứ đã qua một thứ luôn thúc đẩy tôi đó là tạo 1 blog để chia sẻ và viết lại nhưng dòng code, những dòng tâm sự dài dòng mà phải cô đọng.
## Chuẩn bị về kiến thức blog đã nào
Điều bạn cần chuẩn bị cho một blog là một chiếc bàn phím với tối thiểu 44 phím cần thiết cho việc viết lách, một cái đầu vui vẻ sau những phút thảnh thơi giữa cuộc sống bộn bề của bạn.
Về thứ hai, do bây giờ để không dài dòng tôi có thể giới thiệu bạn tới một số trang blog miễn phí trên mạng như
1. [Wordpress](https://wordpress.com/create-blog/) một trang mã nguồn mở cung cấp rất nhiều công cụ quản lý và giao diện đồ sộ, điều tôi không thích là nó quá rườm rà và khá chậm.
2. [Tumblr](https://www.tumblr.com/login) một trang mạng xã hội nhưng vẫn cho phép bạn tạo ra nhưng bài blog có chủ đề và đi kèm với nó là mạng lưới chia sẻ của Tumblr, chắc bạn sẽ phải ngặc nhiên khi có không ít nhưng cây viết Việt trên nền tảng mạng xã hội Tumblr.
3. [Bloger](https://www.blogger.com/about/?bpli=1) Một trang bloger được cung cấp với công cụ quản lý cùng với kho theme rộng rãi, một domain tuy không nhanh nhưng băng thông không giới hạn đủ để bạn có thể thoải mái sáng tạo.
4. [Facebook](https://www.facebook.com) là một trang mạng xã hội, chúng ta có thể chia sẻ rất nhiều chủ đề bài viết, các bạn đừng nghĩ tôi đang nói đến một trang cá nhân vì chuyện đó quá đơn giản mà ở đây đẻ tạo một blog bạn cần tạo một tài khoản facebook sau đó tạo pages facebook, hiện tại có rất nhiều trang facebook theo từng chủ đề như chính trị, giải trí, truyền thông và có thể blog đơn giản của những tay viết nghiệp dư cho đến chuyên nghiệp.
5. [WIX](https://users.wix.com/) Một trang web đang có lượng user đăng ký khá lớn cung cấp domain miễn phí.
6. [Quora](https://www.quora.com/) Một mạng chia sẻ xã hội và những câu hỏi cùng giải đáp rất ý nghĩa
7. [Medium](https://medium.com/) Medium là một sân chơi lớn hơn và cũng là một sân chơi đáng giá nơi bạn có thể chia sẻ các bài viết và ý tướng của mình, ở đây bạn có thể nhận được một khoản nhuận bút nếu bài viết của bạn hay và được rating cao.
8. [Ghost](https://forum.ghost.org/t/how-do-i-create-a-free-ghost-blog-on-netlify/15662) là một trang tạo blog content chuyên nghiệp và hấp dẫn từ kho giao diện cũng như là cung cấp nhưng công cụ quản lý điều duy nhất tôi không thích là bạn sẽ phải trả phí cho muộn public domain lên trên trang web
9. Đây là cách truyền thống, bạn tạo ra website rồi update lên một hosting bất kỳ, có rất nhiều framework hỗ trợ bạn như wordpress, drupal, cakePHP, Yii, Laravel. Hosting bạn có thể tìm đến rất nhiều nhà cung cấp domain tại việt nam cũng như ở singapore với giá rẻ, bạn có thể phải trả phí cho 1 - 2 năm, giá khoảng 2.7 ~ 3 triệu vnđ.
10. [Github](https://pages.github.com/) Github là công cụ quản lý source code mã nguồn mở đang được ưa dùng nhiều nhất hiện nay, chắc bạn cũng từng vài lần qua download nhưng mã nguồn mở hoặc upload các project của bản thân qua đây cũng là lời giới thiệu với mọi người biết bạn là một lập trình viên như nào về tư tưởng cũng như sự đam mê với lập trình. Tôi cũng trong số các bạn thích github và vẫn thường dạo quanh các repository  để tìm hiểu có thể chỉ là một plugin js, css hoặc một dự án về docker cho đến các trang web lớn với các mục địch khác nhau đều được phổ biến tại trang web quản lý này. Đối với mỗi người dùng github bạn chỉ có thể tạo ra một website duy nhất để chia sẻ các dự án và kinh nghiệm của mình, sẽ hợp lý hơn là bạn viết nhưng bài giới thiệu và chủ đề bạn quan tâm đối với mỗi repositories hoặc giả sử bạn là một lập trình viên yêu thích lập trình cần có một trang web hiện đại nhanh chóng được tự cấu hình và lập trình riêng cho nó thi bạn nên chọn lựa github pages. Ở bài viết này tôi sẽ giới thiệu bạn tạo github pages với [jekyll](https://jekyllrb.com/) một trang sinh mã nguồn statics.

## Đăng ký Github pages
**Bước 1: Tạo repository dưới dạng ``usernameweb.github.io`` repository**
![Register](https://i.postimg.cc/7ZfdWS4C/Screenshot-from-2020-08-03-10-23-27.png)
- 1 tài khoản chỉ tạo được 1 blog.

**Bước 2: Trong tab setting chọn branch**
![Setting](https://i.postimg.cc/C19r9xGj/repo-settings.png)

**Bước 3: Chọn theme nếu bạn dùng kho theme miễn phí của github**
![Theme](https://i.postimg.cc/cL32WY9r/launch-theme-chooser.png)
**Bước 4: Clone source code về và init project**
```console
git clone git-ssh-link
cd git-ssh-link
```
Trong thư mục này bạn có thể tạo ra một trang giao diện tùy ý, github pages support js và javascript nhưng không support php hoặc các ngôn ngữ script khác như nodejs, rails, python.

**Bước 5: Khởi tạo jekyll như trang blog quản lý**  
Từ bước này bạn  sẽ có thể hình dung về trang blog của mình sẽ như thế nào rồi đấy.
có thể vào [bài này](/posts/getting-started){:target="_blank"} để làm tiếp bước này nhé.  
**Bước 6: Trang quản lý jekyll**   
Tham khảo [github](https://github.com/jekyll/jekyll-admin) của nhà phát triển.
1.  Add the following to your site's Gemfile:
		```ruby
		gem 'jekyll-admin', group: :jekyll_plugins
		```
2.  Run ``bundle instal``  
![Desktop View.png](https://i.postimg.cc/qBy9r31t/Screenshot-from-2021-03-21-19-24-37.png)

**Bước 7: Cài đặt theme cho jekyll(tùy bạn nhé!)**  
các bạn vào [đây](http://jekyllthemes.org/) để tham khảo kho theme của jekyll.
## Bước tiếp theo ? Làm sao để viết blog !
Để viết một blog hày và có nội dung không phải khó nhưng cũng là một chuyện liên quan đến lối văn chương và kiến thức của từng người. Tôi không biết phải viết thế nào, những bài viết của tôi vẫn sẽ cung cấp cho các bạn những điều mà tôi muốn ghi lại tại đây và chia sẻ 
* [Geting started ](/posts/getting-started){:target="_blank"}
* [Writing a new post](/posts/write-a-new-post/){:target="_blank"}
* [Text and typography ](/posts/text-and-typography/){:target="_blank"}
* [Tutorial](/categories/tutorial/){:target="_blank"}
