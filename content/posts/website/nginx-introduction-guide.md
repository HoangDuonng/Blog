---
title: "Giới thiệu về Nginx 🚀"
author: "Hoàng Dương"
date: "2025-03-10"
draft: false
description: "Nginx là web server mã nguồn mở, hoạt động bất đồng bộ, ban đầu dùng cho HTTP cache nhưng mở rộng hỗ trợ reverse proxy, load balancing và mail proxy, được nhiều công ty lớn sử dụng nhờ khả năng xử lý hàng nghìn kết nối đồng thời."
categories: ["Website"]
tags: ["website", "nginx"]
image: "images/website/nginx-introduction-guide.webp"
---

## 🔀 Nginx là gì?

<p align="center">
  <img src="https://wiki.matbao.net/wp-content/uploads/2019/09/nginx-la-gi.jpg" alt="NGINX là một phần mềm web server mã nguồn mở đáng tin cậy">
</p>
<p align="center"><em>NGINX là một phần mềm web server mã nguồn mở đáng tin cậy</em></p>

Nginx là một phần mềm web server mã nguồn mở, hoạt động theo kiến trúc bất đồng bộ (asynchronous) hướng sự kiện (event-driven). ban đầu được phát triển để phục vụ http cache, nhưng sau này được mở rộng để hỗ trợ reverse proxy, http load balancing và các giao thức truyền mail như imap4, pop3, smtp.

Ra mắt vào tháng 10/2014, Nginx được nhiều công ty lớn như google, adobe, netflix, wordpress sử dụng nhờ khả năng xử lý hàng nghìn kết nối đồng thời.

## ⚙️ Cách hoạt động của Nginx

<p align="center">
  <img src="https://wiki.matbao.net/wp-content/uploads/2019/09/nginx-la-gi-nginx-cung-hoat-dong-tuong-tu-nhu-cac-server-khac.jpg" alt="NGINX cũng hoạt động tương tự như các server khác">
</p>
<p align="center"><em>NGINX cũng hoạt động tương tự như các server khác</em></p>

Nginx hoạt động theo mô hình xử lý bất đồng bộ, khác với cách xử lý tuần tự của các web server truyền thống.

- Mỗi tiến trình (process) sẽ có nhiều worker connections để xử lý các yêu cầu.
- Worker connections gửi yêu cầu đến worker process, worker process chuyển tiếp đến master process để xử lý.
- Nhờ cơ chế này, một worker connection có thể xử lý đến 1024 yêu cầu cùng lúc, giúp Nginx xử lý hàng ngàn yêu cầu hiệu quả.

## 🔥 Các tính năng của Nginx

<p align="center">
  <img src="https://wiki.matbao.net/wp-content/uploads/2019/09/nginx-la-gi-may-chu-nginx-co-nhieu-tinh-nang-va-uu-diem-vuot-troi-trong-lap-trinh.png" alt="Máy chủ NGINX có nhiều tính năng và ưu điểm vượt trội trong lập trình">
</p>
<p align="center"><em>Máy chủ NGINX có nhiều tính năng và ưu điểm vượt trội trong lập trình</em></p>

Nginx sở hữu nhiều tính năng vượt trội:

- ⚡ xử lý hơn 10.000 kết nối đồng thời với mức sử dụng bộ nhớ thấp.
- 📂 phục vụ tập tin tĩnh (static files) và lập chỉ mục tập tin.
- 🔄 cân bằng tải và hỗ trợ proxy ngược với bộ nhớ đệm (cache).
- 🚀 hỗ trợ fastcgi, uwsgi, scgi và memcached.
- 🛠️ kiến trúc modular và nén gzip tự động.
- 🔐 hỗ trợ mã hóa ssl/tls.
- 🔀 rewrite url bằng regular expressions.
- 🌐 hỗ trợ websockets và giới hạn số kết nối đồng thời.
- 📡 tương thích với ipv6.

## ⚖️ So sánh Nginx và Apache server

<p align="center">
  <img src="https://wiki.matbao.net/wp-content/uploads/2019/09/nginx-la-gi-so-voi-apache-server-nginx-server-co-kha-nhieu-uu-diem.jpg" alt="So với Apache server, NGINX server có khá nhiều ưu điểm">
</p>
<p align="center"><em>So với Apache server, NGINX server có khá nhiều ưu điểm</em></p>

### **🖥️ Apache server:**

- xử lý yêu cầu bằng mô hình chia luồng (forked threaded) hoặc keep-alive.
- có thể xử lý cả nội dung tĩnh và động.

### **🌍 Nginx server:**

- sử dụng vòng lặp sự kiện không đồng bộ (non-blocking event loop).
- xử lý nội dung tĩnh hiệu quả hơn Apache.
- tốc độ xử lý truy vấn nhanh hơn và tiết kiệm tài nguyên hơn.
- cần bộ xử lý riêng để hỗ trợ nội dung động.

## 🔎 Hướng dẫn kiểm tra Nginx của website

<p align="center">
  <img src="https://wiki.matbao.net/wp-content/uploads/2019/09/nginx-la-gi-ban-co-the-dua-vao-cac-cong-cu-san-co-de-kiem-tra-website-co-chay-nginx.png" alt="Bạn có thể dựa vào các công cụ sẵn có để kiếm tra website có chạy Nginx">
</p>
<p align="center"><em>Bạn có thể dựa vào các công cụ sẵn có để kiếm tra website có chạy Nginx</em></p>

Bạn có thể kiểm tra website có chạy Nginx hay không bằng cách kiểm tra http header:

1. Mở trang web cần kiểm tra trên trình duyệt chrome.
2. Nhấn **ctrl + shift + i** hoặc **f12** để mở chrome devtools.
3. Chuyển sang tab **network**.
4. Chọn một request bất kỳ và xem phần **headers**.

Ngoài ra, bạn có thể sử dụng công cụ như **pingdom** hoặc **gtmetrix** để kiểm tra.

---

## 🎯 Lời kết  

Nginx đã và đang trở thành một trong những web server phổ biến nhất nhờ hiệu suất cao, khả năng xử lý hàng nghìn kết nối đồng thời và nhiều tính năng mạnh mẽ. Dù bạn cần một giải pháp để phục vụ nội dung tĩnh, cân bằng tải hay làm reverse proxy, Nginx đều có thể đáp ứng một cách hiệu quả. Hy vọng bài viết này giúp bạn hiểu rõ hơn về Nginx và cách nó hoạt động. Nếu bạn đang cân nhắc triển khai một web server tối ưu cho dự án của mình, hãy thử nghiệm Nginx và khám phá những lợi ích mà nó mang lại! 🚀😊
