---
title: "Hướng dẫn cài đặt Nginx trên Ubuntu 24.04 ⚙️"
author: "Hoàng Dương"
date: "2025-03-10"
draft: false
description: "Hướng dẫn chi tiết cách cài đặt và cấu hình Nginx Web Server, giúp bạn nhanh chóng triển khai và tối ưu hiệu suất cho website của mình."
categories: ["Website"]
tags: ["website", "Nginx"]
image: "images/website/how-to-install-nginx.webp"
---

## 📌 Giới thiệu

Nginx là một ứng dụng web server mã nguồn mở giúp triển khai các ứng dụng web tĩnh và động trên máy chủ. Nginx có thể hoạt động như một web server, load balancer, reverse proxy hoặc HTTP cache, hỗ trợ tích hợp với các ứng dụng hiện có để xây dựng một hệ thống hoàn chỉnh hoặc phân phối ứng dụng web qua địa chỉ IP hoặc tên miền.

Bài viết này hướng dẫn cách cài đặt Nginx trên Ubuntu 24.04 và thiết lập ứng dụng web mẫu để chạy trên máy chủ của bạn.

## ✅ Yêu cầu trước khi bắt đầu

Trước khi tiến hành, hãy đảm bảo bạn đã thực hiện các bước sau:

- 🚀 Triển khai một máy chủ Ubuntu 24.04.
- 🌍 Tạo một bản ghi A (A record) cho tên miền hoặc subdomain trỏ đến địa chỉ IP của máy chủ. Ví dụ: `app.example.com`.
- 🔐 Truy cập máy chủ qua SSH và tạo một người dùng không phải root có quyền sudo.
- 🔄 Cập nhật hệ thống.

## ⚙️ Cài đặt NGINX trên Ubuntu 24.04

Gói NGINX mới nhất có sẵn trong kho APT mặc định trên Ubuntu 24.04. Thực hiện các bước sau để cập nhật hệ thống và cài đặt NGINX.

**🔄 Cập nhật danh sách gói hệ thống**
```bash
sudo apt update
```

**📦 Cài đặt NGINX**
```bash
sudo apt install nginx -y
```

**🔍 Kiểm tra phiên bản NGINX đã cài đặt**
```bash
sudo nginx -version
```

Kết quả đầu ra sẽ tương tự như sau:
```
nginx version: nginx/1.24.0 (Ubuntu)
```

---

## ⚙️ Quản lý dịch vụ NGINX

NGINX sử dụng dịch vụ `nginx` trong `systemd` để quản lý thời gian chạy và các tiến trình của web server trên máy chủ. Thực hiện các bước sau để kích hoạt dịch vụ NGINX và quản lý các tiến trình web server.

**🚀 Kích hoạt dịch vụ NGINX khởi động cùng hệ thống**
```bash
sudo systemctl enable nginx
```
**Kết quả:**
```
Synchronizing state of nginx.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable nginx
```

**▶️ Khởi động dịch vụ NGINX**
```bash
sudo systemctl start nginx
```

**⏹️ Dừng dịch vụ NGINX**
```bash
sudo systemctl stop nginx
```

**🔄 Khởi động lại dịch vụ NGINX**
```bash
sudo systemctl restart nginx
```

**🔍 Kiểm tra trạng thái dịch vụ NGINX**
```bash
sudo systemctl status nginx
```

**Kết quả mẫu:**
```
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Wed 2024-06-26 10:55:50 UTC; 1min 0s ago
       Docs: man:nginx(8)
    Process: 2397 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 2399 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 2400 (nginx)
      Tasks: 2 (limit: 1068)
     Memory: 1.7M (peak: 2.4M)
        CPU: 13ms
     CGroup: /system.slice/nginx.service
             ├─2400 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             └─2401 "nginx: worker process"
```

- Dựa vào giá trị `Active: active (running)`, NGINX đang chạy trên máy chủ. Nếu trạng thái hiển thị `Active: active (failed)`, hãy kiểm tra và dừng bất kỳ tiến trình nào đang sử dụng cổng HTTP `80`, sau đó khởi động lại dịch vụ NGINX.

---

## 🌐 Tạo nginx virtual host

Nginx virtual host bao gồm các cấu hình đặc biệt giúp máy chủ web phân phối các tệp ứng dụng web từ một thư mục cụ thể bằng một tên miền cụ thể trên máy chủ của bạn. các bước sau đây sẽ hướng dẫn tạo một cấu hình virtual host mẫu để phân phối tệp ứng dụng web một cách an toàn trên máy chủ.

**📂 Tạo tệp cấu hình virtual host mới**

- Trong thư mục `/etc/nginx/sites-available`, tạo một tệp cấu hình mới, ví dụ: `app.example.com.conf`.

```bash
$ sudo nano /etc/nginx/sites-available/app.example.com.conf
```

- Thêm các cấu hình sau vào tệp:

```nginx
server {
        listen 80;
        listen [::]:80;

        server_name app.example.com;

        root /var/www/app.example.com;
        index index.html;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

- Lưu và đóng tệp.

**✅ Kiểm tra cấu hình Nginx**

- Kiểm tra xem cấu hình Nginx có lỗi không:

```bash
$ sudo nginx -t
```

- Kết quả:

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

**🔗 Kích hoạt virtual host**

- Liên kết tệp cấu hình vào thư mục `/etc/nginx/sites-enabled` để kích hoạt virtual host:

```bash
$ sudo ln -s /etc/nginx/sites-available/app.example.com.conf /etc/nginx/sites-enabled/
```

**📁 Tạo thư mục web root**

```bash
$ sudo mkdir -p /var/www/app.example.com
```

**📝 Tạo tệp html mẫu**
- Tạo tệp `index.html` trong thư mục web root:

```bash
$ sudo nano /var/www/app.example.com/index.html
```

- Thêm nội dung sau vào tệp:

```html
<html>
    <head></head>
    <body>
        <h1>Hello Hoang Duong</h1>
    </body>
</html>
```

- Lưu và đóng tệp.

**🔄 Khởi động lại nginx**

```bash
$ sudo systemctl restart nginx
```

**🌍 Kiểm tra virtual host**

- Sử dụng lệnh `curl` để kiểm tra virtual host:

```bash
$ curl http://app.example.com
```

- Kết quả:

```
Hello Hoang Duong
```

---

## 🔒 Bảo mật máy chủ web Nginx
SSL certificates giúp mã hóa giao tiếp giữa trình duyệt của người dùng và máy chủ Nginx thông qua HTTPS. Mặc định, Nginx lắng nghe kết nối đến trên cổng HTTP 80 không an toàn. Thực hiện các bước sau để tạo chứng chỉ SSL đáng tin cậy từ Let's Encrypt và bảo mật máy chủ Nginx để chấp nhận các yêu cầu kết nối HTTPS được mã hóa.

**Cài đặt Certbot – Let's Encrypt Client 🔧**
- Cài đặt gói Certbot sử dụng Snap:

```sh
$ sudo snap install --classic certbot
```

- Kiểm tra phiên bản Certbot đã cài trên máy chủ:

```sh
$ sudo certbot --version
```

📌 **Đầu ra mẫu:**
```
certbot 2.11.0
```

## 🛡️ Tạo chứng chỉ SSL cho Nginx 
- Tạo chứng chỉ SSL mới cho tên miền của bạn. Thay thế `app.example.com` bằng tên miền thực tế trong cấu hình Virtual Host Nginx:

```sh
$ sudo certbot --nginx -d app.example.com --agree-tos
```

Quá trình này sẽ:  
- ✅ Tạo chứng chỉ SSL hợp lệ  
- ✅ Tự động cấu hình Nginx để sử dụng SSL  
- ✅ Kích hoạt HTTPS trên máy chủ web của bạn  

**Kiểm tra tự động gia hạn chứng chỉ 🔄**
- Các chứng chỉ SSL từ Let's Encrypt có thời hạn 90 ngày. Để đảm bảo không bị hết hạn, bạn có thể kiểm tra tiến trình tự động gia hạn:

```sh
$ sudo certbot renew --dry-run
```

Nếu không có lỗi nào xảy ra, nghĩa là chứng chỉ sẽ được tự động gia hạn đúng hạn.

## 🌐 Kiểm tra trang web hoạt động với https 
- Mở trình duyệt và truy cập:
```
https://app.example.com
```
Nếu thấy biểu tượng ổ khóa 🔒, tức là SSL đã được cài đặt thành công! 🚀

---

## 🔥 Thiết lập quy tắc tường lửa UFW 
Uncomplicated Firewall (UFW) được cài đặt và kích hoạt mặc định trên Ubuntu 24.04. Thực hiện các bước sau để cấu hình tường lửa, cho phép máy chủ Nginx lắng nghe kết nối HTTP và HTTPS.

**Cho phép kết nối HTTP (Cổng 80)🔌**
- Chạy lệnh sau để mở kết nối HTTP:
```sh
$ sudo ufw allow 80/tcp
```

**Cho phép kết nối HTTPS (Cổng 443) 🔐**
- Chạy lệnh sau để mở kết nối HTTPS:
```sh
$ sudo ufw allow 443/tcp
```

**Kiểm tra trạng thái tường lửa 🔢**
- Chạy lệnh sau để xác nhận quy tắc kết nối:
```sh
$ sudo ufw status
```

👉 **Đầu ra mẫu:**
```
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
80/tcp                     ALLOW       Anywhere                  
443/tcp                    ALLOW       Anywhere                  
22/tcp (v6)                ALLOW       Anywhere (v6)             
80/tcp (v6)                ALLOW       Anywhere (v6)             
443/tcp (v6)               ALLOW       Anywhere (v6)             
```

🛡️ Sau khi thiết lập xong, máy chủ sẽ chỉ cho phép kết nối an toàn qua HTTP và HTTPS

---

## 🎯 Lời kết  

Chúc bạn cài đặt thành công Nginx trên máy chủ Ubuntu 24.04 và cấu hình web server để phục vụ các ứng dụng web. Nginx hỗ trợ nhiều cấu hình virtual host giúp bạn triển khai các ứng dụng web một cách an toàn. Ngoài ra, bạn có thể tích hợp Nginx với các ứng dụng khác như MySQL và PHP để xây dựng các ứng dụng web động. Để biết thêm thông tin chi tiết và các tùy chọn cấu hình khác, vui lòng truy cập [tài liệu chính thức](https://docs.nginx.com/) chính thức của Nginx. 🚀😊
