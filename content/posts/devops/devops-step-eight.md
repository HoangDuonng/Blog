---
title: "Giao thức mạng (Networking Protocols) 🖧"
author: "Hoàng Dương"
date: "2025-02-23"
draft: false
description: "Giao thức mạng là tập hợp quy tắc chuẩn hóa đảm bảo dữ liệu được truyền, nhận và hiểu đúng cách bằng cách xác định định dạng, thời gian, trình tự và kiểm soát lỗi trong quá trình truyền."
categories: ["DevOps"]
tags: ["devops", "networking"]
image: "images/devops-step-eight.webp"
---

# 🖧 Giao thức mạng (Networking Protocols)

Giao thức mạng là tập hợp các quy tắc chuẩn hóa giúp dữ liệu được truyền, nhận và hiểu đúng cách trên các mạng máy tính. Chúng xác định định dạng, thời gian, trình tự và kiểm soát lỗi trong quá trình truyền dữ liệu. Một số giao thức quan trọng bao gồm:

- **TCP/IP**: Bộ giao thức nền tảng cho giao tiếp trên Internet.
- **HTTP/HTTPS**: Giao thức truyền tải siêu văn bản dùng cho web.
- **FTP/SFTP**: Giao thức truyền tải tệp tin.
- **SMTP/POP3/IMAP**: Giao thức truyền tải email.
- **DNS**: Giao thức phân giải tên miền.
- **DHCP**: Giao thức cấp phát địa chỉ IP tự động.
- **SSL/TLS**: Giao thức bảo mật dữ liệu.
- **UDP**: Giao thức truyền tải không kết nối, nhanh chóng.

---

## 🌍 Hệ thống tên miền (DNS)
DNS (**Domain Name System**) là hệ thống phân giải tên miền, giúp chuyển đổi tên miền dễ nhớ (vd: `www.example.com`) thành địa chỉ IP (`192.168.1.1`) mà máy tính có thể hiểu được.

### 🔹 Ví dụ cấu hình DNS trong Linux:
```bash
# Kiểm tra DNS của một tên miền
nslookup example.com

dig example.com

# Chỉnh sửa file hosts để ánh xạ tên miền
sudo nano /etc/hosts
# Thêm dòng sau:
192.168.1.100   mycustomdomain.com
```

🔗 **Tài nguyên tham khảo:**
- [📄 Cách hoạt động của DNS](https://howdns.works/)
- [🎥 Video giải thích DNS](https://www.youtube.com/watch?v=Wj0od2ag5sk)

---

## 🌐 Giao thức HTTP
HTTP (**Hypertext Transfer Protocol**) là giao thức truyền tải dữ liệu trên web theo mô hình **yêu cầu - phản hồi**.

### 🔹 Ví dụ gửi yêu cầu HTTP bằng cURL:
```bash
# Gửi yêu cầu GET
curl -X GET https://jsonplaceholder.typicode.com/posts/1

# Gửi yêu cầu POST
curl -X POST https://jsonplaceholder.typicode.com/posts \
     -H "Content-Type: application/json" \
     -d '{"title": "Hello", "body": "World"}'
```

🔗 **Tài nguyên tham khảo:**
- [📄 Tìm hiểu về HTTP](https://www.cloudflare.com/en-gb/learning/ddos/glossary/hypertext-transfer-protocol-http/)
- [🎥 Video hướng dẫn HTTP](https://www.youtube.com/watch?v=iYM2zFP3Zn0)

---

## 🔒 HTTPS và bảo mật (SSL/TLS)
HTTPS là phiên bản bảo mật của HTTP, sử dụng ***SSL/TLS*** để mã hóa dữ liệu, đảm bảo an toàn khi truyền tải trên Internet.

### 🔹 Ví dụ thiết lập HTTPS với Nginx:
```nginx
server {
    listen 443 ssl;
    server_name example.com;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
}
```

🔗 **Tài nguyên tham khảo:**
- [📄 HTTPS là gì?](https://www.cloudflare.com/en-gb/learning/ssl/what-is-https/)
- [🎥 Video HTTPS hoạt động như thế nào](https://www.youtube.com/watch?v=25mXesOV9-8)

---

## 🔑 SSH - Kết nối bảo mật
SSH (***Secure Shell***) là giao thức giúp kết nối an toàn đến máy chủ từ xa.

### 🔹 Ví dụ sử dụng SSH để kết nối từ xa:
```bash
# Kết nối đến máy chủ từ xa
ssh user@example.com

# Sao chép tệp tin từ máy chủ về máy cục bộ
scp user@example.com:/path/to/file ./localfile
```

🔗 **Tài nguyên tham khảo:**
- [📄 Hướng dẫn SSH](https://www.baeldung.com/cs/ssh-intro)
- [🎥 Video cách SSH hoạt động](https://www.youtube.com/watch?v=5JvLV2-ngCI)

---

## 🎯 Kết Luận
Giao thức mạng là nền tảng của mọi hệ thống trực tuyến, từ duyệt web đến gửi email. Hiểu và biết cách sử dụng chúng giúp cải thiện bảo mật và hiệu suất của hệ thống. Hãy thử áp dụng các lệnh trên để kiểm tra và cấu hình hệ thống của bạn! 🚀



👉 **Bước tiếp theo:** Tìm hiểu về ***Cloud Providers***  các công ty cung cấp dịch vụ điện toán đám mây, cho phép cá nhân và doanh nghiệp truy cập tài nguyên như máy chủ, lưu trữ, cơ sở dữ liệu, AI, và các dịch vụ khác qua internet mà không cần đầu tư hạ tầng phần cứng.
