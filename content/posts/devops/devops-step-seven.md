---
title: "Application Gateway 🌐"
author: "Hoàng Dương"
date: "2025-02-23"
draft: false
description: "Bài viết này giúp bạn thiết lập các thành phần mạng quan trọng để quản lý, bảo mật và tối ưu hóa luồng traffic giữa client và server."
categories: ["DevOps"]
tags: ["devops", "nginx", "proxy"]
image: "images/devops-step-seven.webp"
---

# Thiết lập các thành phần mạng quan trọng

Bài viết này sẽ giúp bạn biết các thành phần mạng quan trọng:

🔹 **Forward Proxy**  
🔹 **Reverse Proxy**  
🔹 **Load Balancer**  
🔹 **Firewall**  
🔹 **Caching Server**  
🔹 **Web Server**  

---

## ⚖️ Load Balancer

**Load Balancer** hoạt động như một "cảnh sát giao thông" đứng trước các máy chủ và điều hướng yêu cầu từ khách hàng đến các máy chủ phù hợp. Điều này giúp tối ưu hóa tốc độ, tận dụng tài nguyên hiệu quả và tránh tình trạng quá tải.

🔹 Nếu một máy chủ bị lỗi, Load Balancer sẽ chuyển hướng lưu lượng sang các máy chủ còn lại.

🔹 Có thể triển khai với các thuật toán như Round Robin, Least Connections, IP Hash...

### 🔍 Ví dụ cấu hình Load Balancer với Nginx:
```nginx
upstream backend_servers {
    server backend1.example.com;
    server backend2.example.com;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend_servers;
    }
}
```

📚 **Tham khảo thêm:**  
📄 [Load Balancing là gì?](https://www.nginx.com/resources/glossary/load-balancing/)  
📄 [Các thuật toán Load Balancing](https://www.cloudflare.com/en-gb/learning/performance/what-is-load-balancing/#)  
📄 [Nginx Reverse Proxy & Load Balancing](https://dzone.com/articles/nginx-reverse-proxy-and-load-balancing)  
🎥 [Video: Load Balancer hoạt động như thế nào?](https://www.youtube.com/watch?v=sCR3SAVdyCc)

---

## 🔁 Forward Proxy

**Forward Proxy** là một máy chủ trung gian đứng giữa client và internet, chuyển tiếp yêu cầu từ client đến server đích. Nó giúp ẩn danh, bảo mật, kiểm soát truy cập và caching nội dung.

🔹 Được sử dụng phổ biến trong các mạng doanh nghiệp để giám sát và kiểm soát truy cập.

🔹 Hỗ trợ vượt qua kiểm duyệt và hạn chế địa lý.

### 🔍 Ví dụ cấu hình Forward Proxy với Squid:
```bash
apt update && apt install squid -y

# Chỉnh sửa file cấu hình
nano /etc/squid/squid.conf

# Thêm cấu hình đơn giản
http_access allow all
http_port 3128

# Khởi động lại dịch vụ
systemctl restart squid
```

📚 **Tham khảo thêm:**  
📄 [Forward Proxy là gì?](https://www.fortinet.com/resources/cyberglossary/proxy-server)  
📄 [So sánh Forward Proxy và Reverse Proxy](https://oxylabs.io/blog/reverse-proxy-vs-forward-proxy)  
🎥 [Video: Proxy hoạt động như thế nào?](https://www.youtube.com/watch?v=HrG0MHkSsCA)

---

## 🔄 Reverse Proxy

**Reverse Proxy** là một máy chủ trung gian nhận yêu cầu từ client và chuyển tiếp đến máy chủ backend thích hợp. Nó giúp cân bằng tải, caching, bảo mật và SSL termination.

🔹 Giúp che giấu thông tin của máy chủ backend để tăng cường bảo mật.

🔹 Hỗ trợ phân phối lưu lượng và tối ưu hiệu suất ứng dụng.

### 🔍 Ví dụ cấu hình Reverse Proxy với Nginx:
```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://backend_server;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

📚 **Tham khảo thêm:**  
📄 [Reverse Proxy là gì?](https://www.cloudflare.com/en-gb/learning/cdn/glossary/reverse-proxy/)  
📄 [Hướng dẫn Nginx Reverse Proxy](https://www.nginx.com/resources/glossary/reverse-proxy-server/)  
🎥 [Video: Reverse Proxy và ứng dụng thực tế](https://www.youtube.com/watch?v=4NB0NDtOwIQ)

---

## 🔥 Firewall

**Firewall** là một thiết bị bảo mật mạng giám sát và lọc lưu lượng vào/ra dựa trên chính sách bảo mật của tổ chức.

🔹 Ngăn chặn truy cập trái phép vào hệ thống nội bộ.

🔹 Hỗ trợ các quy tắc kiểm soát lưu lượng dữ liệu.

### 🔍 Ví dụ cấu hình Firewall với UFW (Uncomplicated Firewall):
```bash
# Cài đặt UFW
apt install ufw -y

# Mở cổng SSH
ufw allow 22/tcp

# Chặn tất cả kết nối khác
ufw default deny incoming

# Kích hoạt UFW
ufw enable
```

📚 **Tham khảo thêm:**  
📄 [Firewall là gì?](https://www.checkpoint.com/cyber-hub/network-security/what-is-firewall/)  
📄 [Các loại Firewall phổ biến](https://www.cisco.com/c/en_in/products/security/firewalls/what-is-a-firewall.html)  
🎥 [Video: Giới thiệu về Firewall](https://www.youtube.com/watch?v=9GZlVOafYTg)

---

## 🌐 Nginx

**Nginx** là một máy chủ web mã nguồn mở, được sử dụng rộng rãi nhờ khả năng xử lý nhiều kết nối đồng thời với hiệu suất cao.

🔹 Hỗ trợ web server, reverse proxy, load balancing, caching.

🔹 Thích hợp cho hệ thống microservices và container.

### 🔍 Ví dụ cấu hình Nginx đơn giản:
```nginx
server {
    listen 80;
    server_name example.com;
    root /var/www/html;
    index index.html;
}
```

📚 **Tham khảo thêm:**  
📄 [Hướng dẫn cài đặt Nginx trên Ubuntu](https://swissmade.host/en/blog/basic-nginx-setup-ubuntu-guide-to-a-functional-and-secure-website-serving)  
🎥 [Video: Nginx trong 100 giây](https://www.youtube.com/watch?v=JKxlsvZXG7c)

---

## 🏛️ Apache

**Apache** là một trong những máy chủ web phổ biến nhất, hỗ trợ nhiều module mở rộng và tương thích với nhiều hệ điều hành.

🔹 Dễ dàng cấu hình với file `.conf`.

🔹 Hỗ trợ SSL/TLS, xác thực người dùng, URL rewriting...

### 🔍 Ví dụ cấu hình Apache đơn giản:
```apache
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

📚 **Tham khảo thêm:**  
📄 [Trang chủ Apache](https://httpd.apache.org/)  
🎥 [Video: Cài đặt Apache trên Ubuntu](https://www.youtube.com/watch?v=VXSgEvZKp-8)

---

## ✅ Kết luận

🔹 **Load Balancer** giúp phân phối lưu lượng hiệu quả, giảm tải cho máy chủ.  
🔹 **Forward Proxy** hỗ trợ ẩn danh, caching và kiểm soát truy cập từ client.  
🔹 **Reverse Proxy** giúp tăng cường bảo mật, caching và tối ưu hệ thống backend.  
🔹 **Firewall** bảo vệ hệ thống khỏi truy cập trái phép.  
🔹 **Nginx & Apache** là hai web server phổ biến, phục vụ nội dung web và ứng dụng.  

Bằng cách triển khai các thành phần này, bạn có thể xây dựng một hệ thống mạng mạnh mẽ, bảo mật và hiệu quả. 🚀

👉 **Bước tiếp theo:** Tìm hiểu về ***Networking Protocols***  tập hợp các quy tắc và tiêu chuẩn xác định cách các thiết bị trong mạng giao tiếp với nhau. Chúng đảm bảo dữ liệu được truyền tải chính xác, an toàn và hiệu quả giữa các hệ thống khác nhau.
