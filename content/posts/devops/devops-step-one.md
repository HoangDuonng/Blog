---
title: "Chọn ngôn ngữ lập trình 🤗"
author: "Hoàng Dương"
date: "2025-02-21"
draft: false
description: "Bài viết hướng dẫn chọn ngôn ngữ lập trình phù hợp cho DevOps, bao gồm Python, Bash, Go và Groovy. Nó giải thích lý do chọn từng ngôn ngữ và cung cấp các ví dụ code thực tế như script tự động deploy với Python, cập nhật server với Bash, hiển thị thông tin hệ thống bằng Go và viết pipeline với Groovy. Kết luận khuyến nghị học Python + Bash để bắt đầu và bổ sung Go hoặc Groovy nếu làm việc với Kubernetes hoặc Jenkins."
categories: ["DevOps"]
tags: ["devops", "code"]
image: "images/devops-step-one.webp"
---

# Bước 1: Chọn ngôn ngữ lập trình cho DevOps

## 📌 Tại sao cần chọn ngôn ngữ lập trình?
Trong DevOps, bạn sẽ cần sử dụng ngôn ngữ lập trình để:
- ✅ Viết script tự động hóa.
- ✅ Quản lý server và cloud.
- ✅ Tạo tool hỗ trợ CI/CD.
- ✅ Xây dựng và triển khai hạ tầng dưới dạng code (Infrastructure as Code - IaC).

Việc chọn ngôn ngữ phù hợp giúp bạn làm việc hiệu quả hơn với hệ thống, tự động hóa nhiều quy trình và cải thiện tốc độ phát triển phần mềm.

## 🔥 Ngôn ngữ phù hợp cho DevOps

### 🐍 Python (Khuyến nghị chính)
#### **🔹 Lý do chọn Python:**
- Cú pháp dễ đọc, dễ học.
- Thư viện phong phú hỗ trợ tự động hóa như `fabric`, `paramiko`, `boto3` (AWS SDK), `pyinfra`.
- Hỗ trợ mạnh mẽ trong quản lý Cloud (AWS, GCP, Azure).

#### **🔹 Ứng dụng thực tế:**
- Viết script deploy code tự động.
- Tạo bot quản lý server.
- Xây dựng API quản lý hệ thống.

#### **📝 Ví dụ: Script SSH tự động deploy với Paramiko**
```python
import paramiko

def deploy_code(host, user, password, command):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname=host, username=user, password=password)
    stdin, stdout, stderr = client.exec_command(command)
    print(stdout.read().decode())
    client.close()

deploy_code('192.168.1.100', 'ubuntu', 'yourpassword', 'git pull origin main && systemctl restart app')
```

---

### 🖥️ Bash (Cần biết cơ bản)
#### **🔹 Lý do chọn Bash:**
- Là shell script phổ biến nhất trên Linux.
- Giúp bạn thao tác nhanh với hệ thống.
- Tối ưu cho quản lý server và tự động hóa task nhỏ.

#### **🔹 Ứng dụng thực tế:**
- Viết script tự động update server.
- Tạo cron job chạy định kỳ.
- Quản lý user và permission trên Linux.

#### **📝 Ví dụ: Script tự động update server**
```bash
#!/bin/bash
sudo apt update && sudo apt upgrade -y
```

---

### 🚀 Go (Golang) (Nếu làm với Kubernetes)
#### **🔹 Lý do chọn Go:**
- Hiệu suất cao, dễ dàng biên dịch thành binary nhỏ gọn.
- Kubernetes và nhiều công cụ DevOps như Terraform được viết bằng Go.

#### **🔹 Ứng dụng thực tế:**
- Viết tool quản lý container.
- Tạo plugin cho Kubernetes.
- Xây dựng các công cụ DevOps riêng.

#### **📝 Ví dụ: In ra thông tin hệ thống bằng Go**
```go
package main
import (
    "fmt"
    "os"
)

func main() {
    hostname, _ := os.Hostname()
    fmt.Println("Hostname:", hostname)
}
```

---

### ⚙️ Groovy (Nếu làm việc với Jenkins)
#### **🔹 Lý do chọn Groovy:**
- Là ngôn ngữ chính để viết pipeline trong Jenkins.
- Cú pháp linh hoạt, dễ dàng mở rộng và tích hợp với Java.

#### **🔹 Ứng dụng thực tế:**
- Viết pipeline CI/CD cho Jenkins.
- Tạo script quản lý hệ thống.
- Tự động hóa các bước build, test, deploy.

#### **📝 Ví dụ: Pipeline cơ bản trong Jenkinsfile**
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh './deploy.sh'
            }
        }
    }
}
```

---

## 🎯 Kết luận
- ✅ **Python + Bash** là lựa chọn tốt nhất để bắt đầu DevOps.
- ✅ Nếu làm việc với **Kubernetes**, học thêm **Go**.
- ✅ Nếu làm việc với **Jenkins**, học **Groovy** để viết pipeline.

**👉 Bước tiếp theo:** Học cơ bản về ***Linux & hệ điều hành***.
