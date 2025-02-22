---
title: "Học về Linux & Hệ Điều Hành 🖥️"
author: "Hoàng Dương"
date: "2025-02-22"
draft: false
description: "Bài viết hướng dẫn học Linux và hệ điều hành dành cho DevOps. Bao gồm các lệnh Linux cơ bản, quản lý tiến trình, người dùng, file system, và một script Bash kiểm tra tài nguyên hệ thống."
categories: ["DevOps"]
tags: ["devops", "linux", "bash"]
image: "images/devops-step-two.webp"
---

# 🖥️ Bước 2: Học về Linux & hệ điều hành

## 📌 Tại sao Linux quan trọng trong DevOps?
Linux là nền tảng của hầu hết các hệ thống server, container (Docker, Kubernetes), và cloud. DevOps cần nắm vững Linux để:

- ✅ Quản lý server hiệu quả.
- ✅ Viết script tự động hóa.
- ✅ Xử lý file, user, tiến trình.
- ✅ Tối ưu hệ thống và bảo mật.

---

## ⚙️ Hệ điều hành là gì?
Hệ điều hành (OS) là phần mềm quản lý tài nguyên phần cứng và phần mềm của máy tính, cung cấp dịch vụ chung cho các chương trình. Nó đóng vai trò trung gian giữa ứng dụng và phần cứng, xử lý các nhiệm vụ như:

- 🔹 Quản lý bộ nhớ.
- 🔹 Lập lịch tiến trình.
- 🔹 Quản lý hệ thống file.
- 🔹 Kiểm soát thiết bị.

### 🌍 Các hệ điều hành phổ biến:
- 💻 **Máy tính cá nhân**: Windows, macOS, Linux (Ubuntu, Fedora,...)
- 📱 **Thiết bị di động**: iOS, Android
- 🖥️ **Máy chủ**: Ubuntu Server, Red Hat Enterprise Linux, Windows Server

Mỗi hệ điều hành có đặc điểm, giao diện và khả năng tương thích khác nhau. Chúng đóng vai trò quan trọng trong bảo mật hệ thống, tối ưu hiệu suất và cung cấp trải nghiệm người dùng nhất quán.

---

## 🛠️ Các lệnh Linux cơ bản
Dưới đây là một số lệnh Linux quan trọng:

### 🔍  Kiểm tra hệ thống
```bash
uname -a   # Hiển thị thông tin hệ điều hành
uptime     # Thời gian hoạt động của hệ thống
free -m    # Kiểm tra bộ nhớ RAM
```

### 📂  Quản lý file & thư mục
```bash
ls -l        # Liệt kê file với thông tin chi tiết
mkdir mydir  # Tạo thư mục mới
rm -rf mydir # Xóa thư mục và nội dung bên trong
```

### 🚀  Quản lý tiến trình
```bash
top         # Hiển thị tiến trình đang chạy
ps aux      # Liệt kê tất cả tiến trình
kill -9 PID # Dừng tiến trình theo PID
```

### 👤  Quản lý người dùng
```bash
whoami               # Xem user hiện tại
sudo useradd devops  # Tạo user mới
sudo passwd devops   # Đặt mật khẩu cho user
```

---

## 📜 Script Bash kiểm tra tài nguyên hệ thống
```bash
#!/bin/bash

echo "==== Thông tin hệ thống ===="
uname -a

echo "==== Thời gian hoạt động ===="
uptime

echo "==== Bộ nhớ RAM ===="
free -m
```

### ▶️ **Cách chạy script:**
```bash
chmod +x system_check.sh  # Cấp quyền thực thi cho script
./system_check.sh         # Chạy script trong terminal
```

---

## 📚 Tài nguyên học tập
Dưới đây là một số tài nguyên miễn phí để tìm hiểu thêm về hệ điều hành:

- 📖 [Operating Systems - Wiki](https://en.wikipedia.org/wiki/Operating_system)
- 📖 [All you need to know about OS](https://www.tpointtech.com/operating-system)
- 📖 [Learn Operating Systems](https://www.tutorialspoint.com/operating_system/os_overview.htm)
- 🎥 [What are Operating Systems?](https://www.youtube.com/watch?v=pVzRTmdd9j0)
- 🎥 [Operating Systems](https://www.youtube.com/watch?v=vBURTt97EkA&list=PLBlnK6fEyqRiVhbXDGLXDk_OQAeuVcp2O)

---

## 🎯 Kết luận
- ✅ Linux là kỹ năng bắt buộc trong DevOps.
- ✅ Học cách dùng terminal & Bash scripting.

**👉 Bước tiếp theo:** Tìm hiểu sâu hơn về terminal và cách sử dụng CLI để làm việc hiệu quả với hệ thống.
