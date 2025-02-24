---
title: "CI/CD - Tích hợp liên tục và triển khai liên tục 🚀"
author: "Hoàng Dương"
date: "2025-02-24"
draft: false
description: "Continuous Integration và Continuous Deployment (CI/CD) là quy trình tự động hóa giúp tích hợp, kiểm thử và triển khai phần mềm liên tục, giảm lỗi và rút ngắn thời gian phát hành."
categories: ["DevOps"]
tags: ["devops", "cloud"]
image: "images/devops-step-thirteen.webp"
---

# 🚀 CI/CD - Tích hợp liên tục và Triển khai liên tục

## 🔍 CI/CD là gì?
CI/CD (Continuous Integration/Continuous Deployment) là một phương pháp giúp tự động hóa quá trình phát triển phần mềm, giúp giảm lỗi, tăng tốc độ triển khai và cải thiện chất lượng sản phẩm.

- **Continuous Integration (CI):** Tích hợp liên tục, giúp phát hiện lỗi sớm bằng cách tự động kiểm thử mỗi khi có thay đổi trong mã nguồn.
- **Continuous Deployment (CD):** Triển khai liên tục, đảm bảo phần mềm được phát hành một cách tự động và nhanh chóng.

---

## 🌟 Các công cụ CI/CD phổ biến

### 🔧 Jenkins
Jenkins là một máy chủ tự động hóa mã nguồn mở phổ biến, giúp xây dựng, kiểm thử và triển khai phần mềm một cách tự động.

📌 **Đặc điểm nổi bật:**
- Hỗ trợ nhiều plugin, dễ dàng tích hợp với các công cụ DevOps.
- Giao diện web trực quan, dễ dàng cấu hình.
- Hỗ trợ cả môi trường Windows và Linux.

💡 **Ví dụ:** Cấu hình một pipeline đơn giản trong Jenkinsfile
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
}
```

📖 **Tài nguyên hữu ích:**
- [🔗 Trang chủ Jenkins](https://www.jenkins.io/)
- [🎥 Hướng dẫn Jenkins từ A-Z](https://www.youtube.com/watch?v=6YZvp2GwT0A)

---

### 🔄 CircleCI
CircleCI là một nền tảng CI/CD mạnh mẽ, hỗ trợ nhiều ngôn ngữ lập trình và tích hợp tốt với GitHub, Bitbucket.

📌 **Đặc điểm nổi bật:**
- Hỗ trợ build song song để tăng tốc độ xử lý.
- Tích hợp tốt với Docker và Kubernetes.
- Có phiên bản cloud và self-hosted.

💡 **Ví dụ:** Cấu hình một pipeline CircleCI trong `.circleci/config.yml`
```yaml
version: 2.1
jobs:
  build:
    docker:
      - image: circleci/node:14
    steps:
      - checkout
      - run: npm install
      - run: npm test
```

📖 **Tài nguyên hữu ích:**
- [🔗 Trang chủ CircleCI](https://circleci.com/)
- [🎥 Video hướng dẫn CircleCI](https://www.youtube.com/watch?v=_XaYv9zvHUk)

---

### 🛠️ GitLab CI/CD
GitLab CI/CD là một hệ thống tích hợp sẵn trong GitLab, cho phép tự động hóa quá trình kiểm thử và triển khai ngay trong Git repository.

📌 **Đặc điểm nổi bật:**
- Hỗ trợ tự động hóa toàn bộ pipeline từ build, test đến deploy.
- Có sẵn trong GitLab, không cần công cụ bên ngoài.
- Hỗ trợ cả chạy pipeline trên Docker container.

💡 **Ví dụ:** Cấu hình pipeline GitLab CI/CD trong `.gitlab-ci.yml`
```yaml
stages:
  - build
  - test
  - deploy

test:
  stage: test
  script:
    - npm install
    - npm test
```

📖 **Tài nguyên hữu ích:**
- [🔗 Trang chủ GitLab](https://gitlab.com/)
- [🎥 Hướng dẫn GitLab CI/CD](https://www.youtube.com/watch?v=z7nLsJvEyMY)

---

### ⚡ GitHub Actions
GitHub Actions là công cụ CI/CD được tích hợp trực tiếp vào GitHub, giúp tự động hóa quá trình kiểm thử và triển khai mỗi khi có thay đổi trong repository.

📌 **Đặc điểm nổi bật:**
- Tích hợp chặt chẽ với GitHub, dễ dàng thiết lập workflow.
- Hỗ trợ nhiều hệ điều hành và ngôn ngữ lập trình.
- Có thể sử dụng marketplace với hàng nghìn actions có sẵn.

💡 **Ví dụ:** Workflow GitHub Actions trong `.github/workflows/main.yml`
```yaml
name: Node.js CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 14
      - run: npm install
      - run: npm test
```

📖 **Tài nguyên hữu ích:**
- [🔗 Trang chủ GitHub Actions](https://docs.github.com/en/actions)
- [🎥 Video hướng dẫn GitHub Actions](https://www.youtube.com/watch?v=nyKZTKQS_EQ)

---

## 🎯 Kết luận
CI/CD giúp tăng tốc quá trình phát triển phần mềm, giảm thiểu lỗi và nâng cao chất lượng sản phẩm. Tùy theo nhu cầu và môi trường làm việc, bạn có thể chọn **Jenkins, CircleCI, GitLab CI/CD hoặc GitHub Actions** để triển khai hệ thống CI/CD của mình. 🚀

👉 **Bước tiếp theo:** Tìm hiểu về ***Secret Management***  quá trình lưu trữ, quản lý và bảo vệ các thông tin nhạy cảm như mật khẩu, khóa API, chứng chỉ và token truy cập để ngăn chặn rò rỉ dữ liệu và đảm bảo bảo mật hệ thống. 💡
