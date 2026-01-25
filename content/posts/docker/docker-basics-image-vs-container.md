---
title: "Docker cơ bản: Image vs Container"
author: "Hoàng Dương"
date: "2026-01-25"
draft: false
description: "Hiểu rõ sự khác biệt giữa Docker Image và Container - khái niệm cốt lõi của Docker. Hướng dẫn chi tiết với ví dụ thực tế cho người mới bắt đầu."
categories: ["Docker"]
tags: ["docker", "container", "image", "beginner", "docker-basics"]
image: "images/docker/docker-basics-image-vs-container.webp"
---

## Docker Image và Container - Hai khái niệm thiết yếu

Khi bắt đầu với Docker, hai khái niệm quan trọng nhất bạn cần hiểu là **Image** và **Container**. Nhiều người mới thường nhầm lẫn giữa chúng, nhưng thực chất chúng đóng vai trò khác nhau trong hệ sinh thái Docker. Image giống như **kho chứa recipe** (làm công thức), còn Container là **thực tế thực thi** (món ăn được chuẩn bị). 🍳

Trong bài viết này, tôi sẽ giải thích chi tiết sự khác biệt giữa Image và Container, cách chúng hoạt động cùng nhau, và cung cấp ví dụ thực tế để bạn dễ hiểu hơn.

---

## I. Docker Image là gì?

Docker Image là một **template** (khuôn mẫu) được sử dụng để tạo ra Container. Nó chứa tất cả mọi thứ cần thiết để chạy một ứng dụng:

- Operating system (Hệ điều hành) — thường là Linux minimal
- Runtime environment (Môi trường chạy) — Node.js, Python, Java, v.v.
- Code ứng dụng
- Dependencies (Các thư viện phụ thuộc)
- Configuration files (Files cấu hình)
- Environment variables (Biến môi trường)

### 1. Đặc điểm chính của Docker Image

- **Read-only**: Image là chỉ đọc, không thể thay đổi sau khi đã tạo
- **Layered structure**: Image được xây dựng từ các lớp (layers), mỗi layer đại diện cho một lệnh trong Dockerfile
- **Reusable**: Có thể sử dụng cùng một image để tạo ra nhiều container
- **Version-controlled**: Mỗi image có tag (vd: `1.0`, `latest`, `alpine`) để quản lý phiên bản

**Ví dụ về cấu trúc Image:**

| Layer   | Nội dung                     |
| ------- | ---------------------------- |
| Layer 1 | Base OS (Alpine Linux)       |
| Layer 2 | System packages (curl, wget) |
| Layer 3 | Node.js runtime (18.x)       |
| Layer 4 | Application code             |
| Layer 5 | Environment variables        |

### 2. Các lệnh phổ biến với Image

```bash
# Pull một image từ Docker Hub
docker pull node:18-alpine

# Liệt kê các images đã tải về
docker images

# Xóa một image không sử dụng
docker image rm node:18-alpine

# Xóa tất cả unused images
docker image prune -a

# Build image từ Dockerfile
docker build -t myapp:1.0 .
```

---

## II. Docker Container là gì?

Docker Container là một **thực thể đang chạy** (running instance) được tạo ra từ Docker Image. Container có:

- Một bộ file hệ thống riêng (filesystem)
- Không gian mạng riêng (network isolation)
- Process riêng, hoạt động độc lập
- Các biến môi trường riêng

### 1. Đặc điểm chính của Docker Container

- **Read-only base + Read-write layer**: Container có read-write layer cho phép thay đổi dữ liệu
- **Isolated**: Container cô lập với host và các container khác
- **Stateful**: Container có thể ở các trạng thái: running, stopped, paused, exited
- **Ephemeral**: Container có thể tạo và xóa nhanh chóng (< 1 giây)

**Ví dụ về Container:**

```bash
# Tạo và chạy container từ image
docker run -d --name myapp node:18-alpine node server.js

# Liệt kê các containers đang chạy
docker ps

# Liệt kê tất cả containers (kể cả đã dừng)
docker ps -a

# Dừng container
docker stop myapp

# Khởi động lại container
docker start myapp

# Xóa container
docker rm myapp

# Xem logs của container
docker logs myapp
```

### 2. So sánh Container với Virtual Machine

| Tính chất           | Docker Container        | Virtual Machine             |
| ------------------- | ----------------------- | --------------------------- |
| Hệ điều hành        | Chia sẻ kernel với host | Có OS riêng đầy đủ          |
| Thời gian khởi động | ~ 1-2 giây              | ~ 1-2 phút                  |
| Dung lượng          | MB (10-100 MB)          | GB (1-10 GB)                |
| Hiệu năng           | Gần như native          | Cần virtualization overhead |
| Số lượng tối đa     | Hàng trăm host          | Tẽn vài chục host           |

<p align="center">
  <img src="https://assets.bytebytego.com/diagrams/0414-how-does-docker-work.png" alt="Docker Container Architecture">
  <em>Docker Container Architecture</em>
</p>

---

## III. So sánh chi tiết: Image vs Container

Để dễ hình dung, hãy xem bảng so sánh dưới đây:

### Bảng so sánh đầy đủ

| Khía cạnh         | Image                             | Container                                  |
| ----------------- | --------------------------------- | ------------------------------------------ |
| **Công thức**     | Kho chứa recipe (công thức)       | Món ăn được thực hiện                      |
| **Trạng thái**    | Static (tĩnh, read-only)          | Dynamic (động, read-write)                 |
| **Thay đổi**      | Không thay đổi sau khi tạo        | Có thể thay đổi khi chạy                   |
| **Số lượng**      | Có 1 image, tạo N container       | Nhiều container từ cùng 1 image            |
| **Thời gian tạo** | Chậm (build lần đầu ~5-10 phút)   | Nhanh (< 1 giây)                           |
| **Lưu trữ**       | Lưu trong Docker cache            | Lưu thời gian chạy hoặc volume             |
| **Portability**   | Dễ dàng chia sẻ (push/pull)       | Chỉ chạy trên môi trường đã install Docker |
| **Version**       | Có tag quản lý (1.0, 2.0, latest) | Không có version riêng                     |
| **Network**       | Không                             | Có network riêng                           |
| **Storage**       | Lưu trữ tại layers                | Có read-write layer trên cùng image        |

### Quan hệ giữa Image và Container

```
Docker Image (Template)
      ↓
   docker run
      ↓
Docker Container (Running Instance)
      ↓
   docker commit
      ↓
Docker Image mới (updated)
```

**Lưu ý:**

- **Image** giống như `class` trong OOP (Object Oriented Programming)
- **Container** giống như `object` (instance của class)
- Dùng `docker run` để tạo container từ image
- Dùng `docker commit` để save container thành image mới

---

## IV. Ví dụ thực tế từ đầu đến cuối

Để hiểu rõ hơn, hãy cùng làm một ví dụ chi tiết:

### 1. Tạo Dockerfile (để build image)

```dockerfile
# Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "server.js"]
```

### 2. Build image từ Dockerfile

```bash
# Build image với tên myapp và tag 1.0
docker build -t myapp:1.0 .

# Xem image đã tạo
docker images
# Output:
# REPOSITORY   TAG        IMAGE ID       CREATED        SIZE
# myapp        1.0        abc123def456   2 minutes ago  150MB
```

### 3. Tạo và chạy container từ image

```bash
# Chạy container từ image myapp:1.0
docker run -d \
  --name myapp-container \
  -p 3000:3000 \
  myapp:1.0

# Xem container đang chạy
docker ps
# Output:
# CONTAINER ID   IMAGE       COMMAND            STATUS          PORTS
# xyz789ghi012   myapp:1.0   "node server.js"   Up 2 minutes    0.0.0.0:3000->3000/tcp

# Xem logs
docker logs myapp-container
```

### 4. Tương tác với container

```bash
# Truy cập nội bộ container
docker exec -it myapp-container sh

# Trong container — bạn có thể:
ls -la /app
curl http://localhost:3000
```

### 5. Xóa container và image

```bash
# Dừng container
docker stop myapp-container

# Xóa container
docker rm myapp-container

# Xóa image
docker rmi myapp:1.0
```

---

## V. Best practices với Image và Container

### 1. Quản lý Image

- ✅ Sử dụng cụ thể hơn (ex: `node:18.12-alpine` thay vì `node:latest`)
- ✅ Giảm kích thước bằng base image nhỏ (alpine, distroless)
- ✅ Tận dụng cache layer bằng cách xếp lệnh theo thứ tự
- ✅ Sử dụng `.dockerignore` để loại bỏ file không cần thiết
- ✅ Xóa image unused thường xuyên với `docker image prune`

```bash
# Ví dụ: Sử dụng image cụ thể
FROM node:18.12.1-alpine
# thay vì
FROM node:latest
```

### 2. Quản lý Container

- ✅ Đặt tên container rõ ràng (`--name app-container`)
- ✅ Sử dụng `-d` (detached mode) để chạy container background
- ✅ Thường xuyên quay lại logs khi debug (`docker logs -f`)
- ✅ Sử dụng volumes nếu cần persistence dữ liệu
- ✅ Giới hạn resource với `--cpus`, `--memory`

```bash
# Run container với giới hạn resource
docker run -d \
  --name app \
  --cpus="1.5" \
  --memory="512m" \
  -p 8080:80 \
  myapp:1.0
```

---

## Troubleshooting phổ biến

### 1. Container không thể tạo từ image

**Lỗi:**

```
Error: Cannot start container from image
```

**Nguyên nhân:**

- Image chưa được build hoặc pull về
- Image bị corrupt
- Port đã được sử dụng bởi container khác

**Giải pháp:**

```bash
# Kiểm tra image đã tồn tại chưa
docker images | grep myapp

# Pull về lại nếu chưa có
docker pull myapp:1.0

# Build lại image
docker build -t myapp:1.0 .
```

### 2. Container không lưu dữ liệu khi dừng

**Nguyên nhân:** Container là **ephemeral**, dữ liệu trong container sẽ mất khi nó dừng hoặc xóa.

**Giải pháp:** Sử dụng Docker Volumes

```bash
# Tạo volume
docker volume create myapp-data

# Gắn volume vào container
docker run -d \
  --name app \
  -v myapp-data:/app/data \
  myapp:1.0
```

### 3. Container không truy cập được từ bên ngoài

**Lỗi:** Không thể truy cập `http://localhost:3000` khi run container

**Giải pháp:**

```bash
# Đảm bảo được map port từ container → host
docker run -d \
  --name app \
  -p 3000:3000 \
  myapp:1.0

# Nếu là multi-container, sử dụng docker network
docker network create mynet
docker run -d --network mynet --name app1 myapp:1.0
docker run -d --network mynet --name app2 myapp:1.0
```

---

## Ghi chú triển khai 🔧

**Khi áp dụng vào dự án của bạn**, hãy lưu ý các điểm quan trọng:

- **Đừng thay đổi trực tiếp container** — Hãy build lại image với Dockerfile
- **Sử dụng docker-compose.yaml** để quản lý nhiều container và dependencies
- **Sử dụng CI/CD** để tự động build và push image lên Docker Hub/Registry
- **Giám sát ресурс** với `docker stats` hoặc Prometheus + Grafana
- **Backup dữ liệu** thường xuyên từ volumes

**Best practices:**

- Luôn đặt tên image và container rõ ràng
- Sử dụng tags cụ thể cho môi trường khác nhau (dev, staging, prod)
- Viết `.dockerignore` để giảm kích thước image và tăng tốc build
- Sử dụng multi-stage build để tạo image nhỏ nhất

**Troubleshooting:**

- Khi container bị crash, xem logs: `docker logs <container-name>`
- Khi container không thể pull image, kiểm tra network: `ping registry-1.docker.io`
- Khi container không có quyền truy cập file, gắn volume đúng permission

---

## 🎯 Lời kết

Tóm tắt lại:

- **Docker Image = Kho chứa recipe (template read-only)** — Chứa tất cả thiết lập để chạy ứng dụng
- **Docker Container = Món ăn được thực hiện (running instance)** — Container được tạo từ image, read-write layer
- Image là tĩnh, Container là động
- Dùng `docker run` để tạo container từ image
- Dùng `docker commit` để update container thành image mới

Bây giờ bạn đã hiểu rõ sự khác biệt giữa Image và Container. Bước tiếp theo: học cách sử dụng Dockerfile để build image, và Docker Compose để quản lý nhiều container. 🚀

Nếu bạn thấy bài viết này hữu ích, hãy nhớ ⭐ star repo hoặc 📱 chia sẻ với bạn bè nhé! 😊

---

## Tài liệu tham khảo

- [Docker Official Documentation](https://docs.docker.com/)
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/dev-best-practices/)
