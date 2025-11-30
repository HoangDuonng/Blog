---
title: "Cách cài đặt Docker trên Ubuntu 🐳"
author: "Hoàng Dương"
date: "2025-11-30"
draft: false
description: "Hướng dẫn chi tiết cách cài đặt Docker trên Ubuntu 20.04 và 22.04 một cách đơn giản và hiệu quả, bao gồm cấu hình quyền user và kiểm tra hoạt động."
categories: ["Installation Guides"]
tags: ["docker", "ubuntu", "container", "devops"]
image: "images/installation-guides/docker-installation-ubuntu.webp"
---

## 🐳 Giới thiệu về Docker

Docker là một nền tảng phổ biến trong DevOps để triển khai ứng dụng bằng **container**. Container cho phép bạn đóng gói ứng dụng cùng với tất cả các dependencies và cấu hình cần thiết, giúp ứng dụng chạy nhất quán trên mọi môi trường từ development đến production.

**Lợi ích của Docker:**
- ⚡ **Tính nhất quán**: Ứng dụng chạy giống nhau trên mọi môi trường
- 🚀 **Tốc độ**: Khởi động container nhanh hơn so với virtual machine
- 📦 **Đóng gói**: Dễ dàng chia sẻ và triển khai ứng dụng
- 🔄 **Scalability**: Dễ dàng mở rộng và quản lý nhiều container

Bài viết này hướng dẫn bạn cách cài đặt Docker trên Ubuntu 20.04 và 22.04 một cách đơn giản và hiệu quả, sử dụng repository chính thức của Docker để đảm bảo bạn luôn có phiên bản mới nhất và ổn định.

---

## ✅ Yêu cầu trước khi cài đặt

Trước khi bắt đầu, hãy đảm bảo bạn có:

- 🖥️ **Máy chủ Ubuntu 20.04 hoặc 22.04** đã được cài đặt
- 🔐 **Quyền sudo** để thực thi các lệnh quản trị
- 🌐 **Kết nối internet** để tải các gói cài đặt
- ⏱️ **Thời gian**: Quá trình cài đặt mất khoảng 5-10 phút

---

## 1. Cập nhật hệ thống

Trước khi cài đặt Docker, hãy đảm bảo hệ thống được cập nhật đầy đủ. Điều này giúp đảm bảo bạn có các bản vá bảo mật mới nhất và các gói phụ thuộc cần thiết.

```bash
sudo apt update && sudo apt upgrade -y
```

**💡 Lưu ý:**
- Lệnh `apt update` cập nhật danh sách các gói có sẵn từ repository
- Lệnh `apt upgrade -y` tự động cài đặt các bản cập nhật mà không cần xác nhận
- Quá trình này có thể mất vài phút tùy thuộc vào số lượng gói cần cập nhật

---

## 2. Cài đặt Docker

### 2.1. Cài đặt các gói phụ thuộc

Các gói này cần thiết để Docker có thể tải và xác thực các gói từ repository chính thức:

- `apt-transport-https`: Cho phép APT sử dụng giao thức HTTPS
- `ca-certificates`: Cung cấp chứng chỉ SSL/TLS để xác thực kết nối bảo mật
- `curl`: Công cụ để tải xuống các file từ internet
- `software-properties-common`: Cung cấp các tiện ích để quản lý repository

```bash
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
```

### 2.2. Thêm repository Docker chính thức

Để cài đặt Docker từ nguồn chính thức, chúng ta cần thêm GPG key và repository của Docker vào hệ thống. Điều này đảm bảo bạn nhận được các bản cập nhật chính thức và bảo mật từ Docker.

**Bước 1: Thêm GPG key của Docker**

GPG key được sử dụng để xác thực tính toàn vẹn của các gói Docker:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

**Bước 2: Thêm Docker repository**

Thêm repository Docker vào danh sách nguồn của APT. Lệnh này tự động phát hiện phiên bản Ubuntu của bạn (`$(lsb_release -cs)`) và thêm repository phù hợp:

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

**💡 Giải thích:**
- `arch=amd64`: Chỉ định kiến trúc 64-bit
- `signed-by`: Chỉ định GPG key để xác thực
- `$(lsb_release -cs)`: Tự động lấy tên code name của Ubuntu (ví dụ: jammy cho Ubuntu 22.04)
- `stable`: Sử dụng channel ổn định (có thể dùng `test` hoặc `nightly` cho các phiên bản thử nghiệm)

### 2.3. Cài đặt Docker Engine

Sau khi đã thêm repository, cập nhật danh sách gói và cài đặt Docker Engine:

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

**📦 Các gói được cài đặt:**
- `docker-ce`: Docker Community Edition - phiên bản mã nguồn mở của Docker
- `docker-ce-cli`: Docker Command Line Interface - công cụ dòng lệnh để tương tác với Docker
- `containerd.io`: Container runtime - công cụ quản lý vòng đời container ở mức thấp

**⏱️ Thời gian cài đặt:** Quá trình này thường mất 2-5 phút tùy thuộc vào tốc độ internet của bạn.

---

## 3. Kiểm tra Docker

Sau khi cài đặt, hãy kiểm tra xem Docker đã được khởi động và hoạt động chưa:

```bash
sudo systemctl status docker
```

**Kết quả mong đợi:** Bạn sẽ thấy trạng thái `active (running)` nếu Docker đã khởi động thành công.

Nếu Docker chưa chạy, bạn có thể khởi động và kích hoạt Docker để tự động khởi động khi hệ thống boot:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

**💡 Giải thích các lệnh:**
- `systemctl start docker`: Khởi động dịch vụ Docker ngay lập tức
- `systemctl enable docker`: Cấu hình Docker tự động khởi động khi hệ thống khởi động lại

---

## 4. Chạy thử Docker

Để xác nhận Docker đã hoạt động đúng, chạy container mẫu `hello-world`:

```bash
sudo docker run hello-world
```

**Kết quả mong đợi:** Nếu thấy thông báo "Hello from Docker!" cùng với các thông tin về Docker, nghĩa là bạn đã cài đặt thành công! 🎉

**🔍 Container `hello-world` làm gì?**
- Container này tải xuống image `hello-world` từ Docker Hub (nếu chưa có)
- Chạy container và hiển thị thông báo chào mừng
- Tự động dừng sau khi hoàn thành

---

## 5. Cấu hình quyền cho user

Mặc định, Docker yêu cầu quyền root để chạy các lệnh. Để chạy Docker không cần `sudo`, bạn cần thêm user hiện tại vào nhóm `docker`:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

**💡 Giải thích:**
- `usermod -aG docker $USER`: Thêm user hiện tại vào nhóm `docker` (nhóm này có quyền truy cập Docker daemon)
- `newgrp docker`: Áp dụng thay đổi nhóm ngay lập tức mà không cần đăng xuất

**⚠️ Lưu ý quan trọng:**
- Sau khi thực hiện lệnh này, bạn có thể cần đăng xuất và đăng nhập lại để thay đổi có hiệu lực
- Hoặc bạn có thể mở terminal mới để áp dụng thay đổi
- Việc thêm user vào nhóm `docker` cho phép user đó có quyền tương đương root trên Docker daemon, vì vậy chỉ thêm những user đáng tin cậy

**Kiểm tra quyền mới:**

Sau khi cấu hình, thử chạy Docker không cần `sudo`:

```bash
docker run hello-world
```

Nếu lệnh chạy thành công mà không cần `sudo`, bạn đã cấu hình đúng! ✅

---

## 6. Gỡ cài đặt Docker (nếu cần)

Nếu bạn muốn gỡ cài đặt Docker hoàn toàn khỏi hệ thống, thực hiện các bước sau:

**Bước 1: Gỡ cài đặt các gói Docker**

```bash
sudo apt remove -y docker-ce docker-ce-cli containerd.io
```

**Bước 2: Xóa dữ liệu Docker**

Dữ liệu Docker (images, containers, volumes, networks) được lưu trong `/var/lib/docker`. Để xóa hoàn toàn:

```bash
sudo rm -rf /var/lib/docker
```

**⚠️ Cảnh báo:** Lệnh này sẽ xóa **TẤT CẢ** dữ liệu Docker bao gồm:
- Tất cả images đã tải về
- Tất cả containers (đang chạy và đã dừng)
- Tất cả volumes và networks
- Tất cả dữ liệu trong containers

**Bước 3: Xóa cấu hình Docker (tùy chọn)**

Nếu muốn xóa hoàn toàn mọi dấu vết của Docker:

```bash
sudo rm -rf /var/lib/containerd
sudo rm -rf /etc/docker
```

---

## 📚 Các lệnh Docker cơ bản

Sau khi cài đặt Docker, đây là một số lệnh cơ bản bạn nên biết:

| Lệnh | Mô tả |
| --- | --- |
| `docker --version` | Kiểm tra phiên bản Docker |
| `docker ps` | Liệt kê các container đang chạy |
| `docker ps -a` | Liệt kê tất cả containers (bao gồm đã dừng) |
| `docker images` | Liệt kê tất cả images |
| `docker pull <image>` | Tải image từ Docker Hub |
| `docker run <image>` | Chạy container từ image |
| `docker stop <container>` | Dừng container đang chạy |
| `docker rm <container>` | Xóa container |
| `docker rmi <image>` | Xóa image |

---

## 🔧 Troubleshooting

### Vấn đề: Docker daemon không khởi động

**Nguyên nhân:** Có thể do xung đột với các dịch vụ khác hoặc cấu hình sai.

**Giải pháp:**
```bash
# Kiểm tra log của Docker
sudo journalctl -u docker

# Khởi động lại Docker
sudo systemctl restart docker
```

### Vấn đề: Permission denied khi chạy Docker

**Nguyên nhân:** User chưa được thêm vào nhóm `docker`.

**Giải pháp:**
```bash
# Thêm user vào nhóm docker
sudo usermod -aG docker $USER

# Đăng xuất và đăng nhập lại, hoặc chạy:
newgrp docker
```

### Vấn đề: Không thể kết nối đến Docker daemon

**Nguyên nhân:** Docker daemon chưa được khởi động.

**Giải pháp:**
```bash
# Kiểm tra trạng thái
sudo systemctl status docker

# Khởi động Docker
sudo systemctl start docker
```

---

## 🎯 Lời kết

Vậy là chúng ta đã hoàn tất cài đặt Docker trên Ubuntu! 🎉 Giờ đây, bạn có thể bắt đầu:

- 🐳 **Tạo và chạy containers** cho các ứng dụng của mình
- 📦 **Sử dụng Docker images** có sẵn từ Docker Hub
- 🚀 **Triển khai ứng dụng** một cách nhất quán và dễ dàng
- 🔄 **Quản lý môi trường development** và production hiệu quả hơn

Docker là một công cụ mạnh mẽ trong thế giới DevOps. Hãy tiếp tục khám phá các tính năng của Docker như Docker Compose, Docker Swarm, và tích hợp với các công cụ CI/CD để tối ưu hóa quy trình phát triển của bạn!

**📖 Tài liệu tham khảo:**
- [Tài liệu chính thức của Docker](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/) - Kho lưu trữ images lớn nhất
- [Best practices cho Docker](https://docs.docker.com/develop/dev-best-practices/)

Chúc bạn thành công với Docker! 🚀😊

