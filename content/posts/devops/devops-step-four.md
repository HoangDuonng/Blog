---
title: "Hệ thống quản lý phiên bản (Version Control Systems) 🛠️"
author: "Hoàng Dương"
date: "2025-02-23"
draft: false
description: "Bài viết cung cấp kiến thức tổng quan về hệ thống quản lý phiên bản (VCS), tập trung vào Git – công cụ phổ biến nhất. Nội dung bao gồm các khái niệm cơ bản, hướng dẫn cài đặt, các lệnh Git quan trọng được sắp xếp từ cơ bản đến nâng cao, cùng với tài nguyên học tập miễn phí, giúp người đọc nắm vững cách quản lý mã nguồn hiệu quả."
categories: ["DevOps"]
tags: ["devops", "git", "github"]
image: "images/devops/devops-step-four.webp"
---

## 🔄 Hệ thống quản lý phiên bản (Version Control Systems)

Version control systems (VCS) là các công cụ giúp theo dõi sự thay đổi của mã nguồn và tệp theo thời gian. Chúng hỗ trợ làm việc nhóm, quản lý lịch sử thay đổi và duy trì nhiều phiên bản của mã nguồn. Có hai loại VCS chính:

- **Hệ thống tập trung (Centralized VCS - CVCS)**: Sử dụng một kho lưu trữ trung tâm, ví dụ như **Subversion (SVN)**, **CVS**.
- **Hệ thống phân tán (Distributed VCS - DVCS)**: Mỗi người dùng có một bản sao đầy đủ của kho lưu trữ, bao gồm toàn bộ lịch sử. Ví dụ phổ biến nhất là **Git**.

Git là một hệ thống quản lý phiên bản phân tán mạnh mẽ, cho phép làm việc ngoại tuyến, hỗ trợ nhanh chóng các thao tác nhánh (branching) và hợp nhất (merging), giúp tăng cường khả năng cộng tác.

---

## 🛠️ Git - Công Cụ Quản Lý Phiên Bản Phổ Biến Nhất

### 🔹 Cài Đặt Git
Nếu chưa cài đặt Git, bạn có thể tải về từ [git-scm.com](https://git-scm.com/) hoặc sử dụng lệnh sau:

```bash
sudo apt install git    # Ubuntu/Debian
yum install git         # CentOS/RHEL
brew install git        # macOS
```

Xác nhận cài đặt Git:
```bash
git --version

# output: 
# git version 2.47.1.windows.1
```

---

## 🚀 Các Lệnh Cơ Bản Trong Git
Dưới đây là các lệnh Git phổ biến, được sắp xếp từ cơ bản đến nâng cao:

###  **Khởi Tạo & Cấu Hình**
```bash
git init                    # Khởi tạo kho lưu trữ Git
```
```bash
git config --global user.name "Tên Của Bạn"          # Cấu hình tên
git config --global user.email "email@example.com"   # Cấu hình email
```

###  **Làm Việc Với Kho Lưu Trữ**
```bash
git clone <repo_url>    # Sao chép một kho lưu trữ từ xa về máy
```
```bash
git status              # Kiểm tra trạng thái của các tệp
```

###  **Thêm & Lưu Thay Đổi**
```bash
git add <file>                   # Thêm tệp vào vùng tạm
```
```bash
git commit -m "Mô tả thay đổi"   # Lưu thay đổi vào lịch sử
```

###  **Làm Việc Với Kho Lưu Trữ Từ Xa**
```bash
git remote add origin <repo_url>   # Liên kết kho lưu trữ từ xa
```
```bash
git push -u origin main            # Đẩy thay đổi lên nhánh chính
```
```bash
git pull origin main               # Cập nhật thay đổi mới nhất từ kho lưu trữ từ xa
```

###  **Làm Việc Với Nhánh**
```bash
git branch new-feature     # Tạo nhánh mới
```
```bash
git checkout new-feature   # Chuyển sang nhánh mới
```
```bash
git merge new-feature      # Gộp nhánh vào nhánh hiện tại
```

###  **Theo Dõi Lịch Sử**
```bash
git log                    # Xem lịch sử commit
```
```bash
git diff                   # So sánh thay đổi giữa các phiên bản
```

---

## 📚 Tài Nguyên Học Git Miễn Phí
- [📖 Tài liệu chính thức về Git](https://git-scm.com/doc)
- [📄 Git Cheat Sheet](https://cs.fyi/guide/git-cheatsheet)
- [▶️ Video hướng dẫn Git cho người mới bắt đầu](https://www.youtube.com/watch?v=SWYqp7iY_Tc)
- [📝 Bài viết: Hệ thống quản lý phiên bản là gì?](https://app.daily.dev/tags/git?ref=roadmapsh)

---

## 🔚 Kết Luận
Sử dụng Git giúp quản lý mã nguồn dễ dàng hơn, hỗ trợ làm việc nhóm hiệu quả và bảo vệ dữ liệu quan trọng của dự án. Việc hiểu và thành thạo Git là kỹ năng cần thiết cho mọi lập trình viên.

👉 **Bước tiếp theo:** Tìm hiểu về ***GitHub & GitLab*** để quản lý kho lưu trữ Git trên nền tảng đám mây.

