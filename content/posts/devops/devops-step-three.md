---
title: "Kiến thức về Terminal 📟"
author: "Hoàng Dương"
date: "2025-02-23"
draft: false
description: "Bài viết cung cấp kiến thức tổng quan về Terminal, giám sát hệ thống, công cụ mạng, xử lý văn bản và lập trình Bash, giúp người dùng làm việc hiệu quả hơn với Linux và DevOps."
categories: ["DevOps"]
tags: ["devops", "terminal", "bash"]
image: "images/devops-step-three.webp"
---

## 🖥️ Kiến thức về Terminal
Terminal là một giao diện văn bản giúp người dùng tương tác với hệ thống máy tính thông qua CLI (Command Line Interface - Giao diện dòng lệnh). Đây là công cụ quan trọng để quản lý hệ thống, thực thi lệnh, và tự động hóa các tác vụ.

### 📚 Tài Nguyên Miễn Phí
- [📄 Bài viết: CLI là gì?](https://en.wikipedia.org/wiki/Command-line_interface)
- [🔍 Tìm kiếm trên Google](https://www.google.com/search?q=terminal%20knowledge%20guide%20for%20devops)
- [▶️ Tìm kiếm trên YouTube](https://www.youtube.com/results?search_query=terminal%20knowledge%20for%20devops)

🔹 **Ví dụ:**
```bash
ls -l  # Liệt kê tệp trong thư mục hiện tại
pwd    # Hiển thị đường dẫn thư mục hiện tại
```
---

## 📊 Giám Sát Tiến Trình (Process Monitoring)
Giám sát tiến trình là quá trình quan sát và phân tích liên tục các tiến trình trong hệ thống IT để đảm bảo hiệu suất, hiệu quả và tuân thủ quy định. Nó giúp theo dõi các thông số quan trọng như tài nguyên sử dụng, hành vi của từng tiến trình hoặc ứng dụng đang chạy trong hệ thống.

### 🏆 Công Cụ Được Đề Xuất
- **🟣 lsof** - Liệt kê thông tin về các tệp được mở bởi tiến trình.

### 📚 Tài Nguyên Miễn Phí
- [📄 Lsof Cheat Sheet](https://neverendingsecurity.wordpress.com/2015/04/13/lsof-commands-cheatsheet/)
- [📖 Tài liệu lsof](https://man7.org/linux/man-pages/man8/lsof.8.html)
- [▶️ Video: Linux Crash Course - Lệnh lsof](https://www.youtube.com/watch?v=n9nZ1ellaV0)
- [📝 Bài viết hay về Giám sát](https://app.daily.dev/tags/monitoring?ref=roadmapsh)

🔹 **Ví dụ:**
```bash
lsof -i :80  # Liệt kê tiến trình sử dụng cổng 80
ps aux       # Hiển thị tất cả tiến trình đang chạy
```
---

## 🚀 Giám Sát Hiệu Suất (Performance Monitoring)
Giám sát hiệu suất giúp thu thập, phân tích và báo cáo các chỉ số hiệu suất chính từ ứng dụng, mạng, máy chủ và cơ sở dữ liệu.

### 🏆 Công Cụ Được Đề Xuất
- **🟣 vmstat** - Công cụ theo dõi bộ nhớ ảo và hiệu suất hệ thống.

### 📚 Tài Nguyên Miễn Phí
- [📖 Lệnh Linux: Khám phá bộ nhớ ảo với vmstat](https://www.redhat.com/sysadmin/linux-commands-vmstat)
- [📄 Tài liệu vmstat](https://man7.org/linux/man-pages/man8/vmstat.8.html)
- [▶️ Hướng dẫn vmstat](https://phoenixnap.com/kb/vmstat-command)
- [📝 Bài viết hay về Giám sát](https://app.daily.dev/tags/monitoring?ref=roadmapsh)

🔹 **Ví dụ:**
```bash
vmstat 5 10  # Cập nhật trạng thái hệ thống mỗi 5 giây trong 10 lần
```
---

## 🌐 Công Cụ Mạng (Networking Tools)
Các công cụ mạng hỗ trợ giám sát, phân tích, khắc phục sự cố và quản lý hệ thống mạng.

### 🏆 Công Cụ Được Đề Xuất
- **🟣 Wireshark** - Phân tích gói tin sâu.
- **🟣 Nmap** - Quét mạng và kiểm tra bảo mật.
- **Ping** - Kiểm tra kết nối cơ bản.
- **Traceroute** - Xác định đường đi của gói tin trong mạng.
- **Netstat** - Hiển thị kết nối mạng.
- **Tcpdump** - Ghi và phân tích gói tin trên dòng lệnh.
- **Iperf** - Kiểm tra hiệu suất mạng.
- **Netcat** - Thực hiện nhiều tác vụ mạng khác nhau.
- **Nslookup/Dig** - Truy vấn DNS.
- **PuTTY** - Kết nối từ xa qua SSH hoặc Telnet.

🔹 **Ví dụ:**
```bash
ping google.com        # Kiểm tra kết nối đến Google
nmap -sS 192.168.1.1  # Quét cổng máy chủ nội bộ
```
---

## ✂️ Xử Lý Văn Bản (Text Manipulation)
Các công cụ hỗ trợ chỉnh sửa, xử lý và chuyển đổi dữ liệu văn bản.

### 🏆 Công Cụ Được Đề Xuất
- **🟣 sed** - Chỉnh sửa luồng dữ liệu.
- **🟣 awk** - Quét mẫu và trích xuất dữ liệu.
- **🟣 grep** - Tìm kiếm văn bản bằng biểu thức chính quy.
- **cut, sort, tr, uniq** - Các lệnh hỗ trợ xử lý dữ liệu văn bản.

🔹 **Ví dụ:**
```bash
grep "error" logfile.txt  # Tìm từ "error" trong logfile.txt
awk '{print $1}' data.txt  # Lấy cột đầu tiên từ file data.txt
```
---

## ⚡ Bash Scripts
Bash là một shell mạnh mẽ trên Unix/Linux, giúp thực hiện lệnh và tự động hóa tác vụ.

🔹 **Ví dụ:**
```bash
#!/bin/bash
echo "Hello, World!"
```
---

## ✍️ Trình Soạn Thảo (Editors)
Trình soạn thảo văn bản là công cụ quan trọng để chỉnh sửa và quản lý tệp văn bản.

### 🏆 Công Cụ Được Đề Xuất
- **🟣 Vim** - Mạnh mẽ, tùy biến cao, phù hợp cho lập trình viên.
- **🟣 Emacs** - Linh hoạt, có nhiều plugin hỗ trợ.
- **Sublime Text** - Tốc độ cao, giao diện thân thiện.
- **Visual Studio Code** - Mã nguồn mở, hỗ trợ gỡ lỗi, mở rộng, tích hợp công cụ phát triển.

🔹 **Ví dụ:**
```bash
vim myfile.txt  # Mở tệp bằng Vim
nano myfile.txt # Mở tệp bằng Nano
```
---

## 🔚 Kết Luận
Hiểu và sử dụng thành thạo các công cụ trên giúp bạn làm việc hiệu quả hơn trong môi trường Linux và DevOps. Các công cụ ***🟣 được đánh dấu*** là những công cụ phổ biến và mạnh mẽ nhất, được nhiều chuyên gia khuyến nghị. Bạn có thể tìm hiểu sâu hơn thông qua các tài nguyên miễn phí đi kèm. Nếu có điều gì cần làm rõ hoặc bổ sung, hãy phản hồi để mình cập nhật nhé!

**👉 Bước tiếp theo:** Nâng cao kiến thức về hệ thống quản lý phiên bản (***Version Control Systems***) để theo dõi, quản lý và cộng tác hiệu quả trên mã nguồn.