---
title: "Serverless và các nền tảng liên quan ☁️"
author: "Hoàng Dương"
date: "2025-02-24"
draft: false
description: "Serverless là mô hình điện toán đám mây nơi nhà cung cấp dịch vụ quản lý hạ tầng, tự động phân bổ tài nguyên theo nhu cầu và chỉ tính phí theo mức sử dụng, giúp lập trình viên tập trung vào viết mã và tối ưu vận hành."
categories: ["DevOps"]
tags: ["devops", "cloud"]
image: "images/devops/devops-step-ten.webp"
---

## 🚀 Serverless là gì?

Serverless là mô hình điện toán đám mây nơi nhà cung cấp dịch vụ quản lý hoàn toàn cơ sở hạ tầng, giúp lập trình viên chỉ cần tập trung vào viết mã. Hệ thống sẽ **tự động phân bổ tài nguyên** theo nhu cầu và chỉ tính phí dựa trên tài nguyên thực tế sử dụng. Kiến trúc serverless thường được áp dụng cho các **ứng dụng microservices, xử lý sự kiện** và giúp giảm thiểu chi phí vận hành.

📖 **Tài nguyên miễn phí để tìm hiểu:**
- 📄 [Serverless là gì?](https://www.redhat.com/en/topics/cloud-native-apps/what-is-serverless)
- 🎥 [Giới thiệu về Serverless](https://www.youtube.com/watch?v=vxJobGtqKVM)
- 🌍 [Bài viết hay về Serverless](https://app.daily.dev/tags/serverless?ref=roadmapsh)

---

## ⚡ AWS Lambda

AWS Lambda là một dịch vụ serverless của AWS, cho phép chạy mã mà không cần quản lý máy chủ. Lambda **tự động mở rộng** theo nhu cầu, hỗ trợ nhiều ngôn ngữ lập trình và dễ dàng tích hợp với các dịch vụ khác của AWS. Nó phù hợp với **xử lý dữ liệu, tự động hóa tác vụ, xây dựng microservices**.

🖥️ **Ví dụ:** Triển khai một function trên AWS Lambda
```python
import json
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from AWS Lambda!')
    }
```

📖 **Tài nguyên miễn phí để tìm hiểu:**
- 🔗 [Giới thiệu AWS Lambda](https://docs.aws.amazon.com/lambda/latest/operatorguide/intro.html)
- 🎥 [Hướng dẫn AWS Lambda từ A-Z](https://www.youtube.com/watch?v=RtiWU1DrMaM)
- 🌍 [Bài viết hay về AWS Lambda](https://app.daily.dev/tags/aws?ref=roadmapsh)

---

## 🌍 Cloudflare

Cloudflare là một công ty cung cấp dịch vụ **CDN, bảo mật, tối ưu hiệu suất** cho website. Cloudflare đóng vai trò là **proxy ngược**, giúp tăng tốc tải trang và bảo vệ website khỏi các cuộc tấn công. Công ty được thành lập năm 2009 và lên sàn chứng khoán vào năm 2019.

📖 **Tài nguyên miễn phí để tìm hiểu:**
- 🔗 [Trang chủ Cloudflare](https://cloudflare.com/)
- 🎥 [Giới thiệu về Cloudflare](https://www.youtube.com/watch?v=24cml1rKGBs)
- 🌍 [Bài viết hay về Cloudflare](https://app.daily.dev/tags/cloudflare?ref=roadmapsh)

---

## 🌐 Vercel

Vercel là nền tảng **triển khai frontend** giúp đưa các ứng dụng web lên cloud một cách nhanh chóng. Nó hỗ trợ **React, Next.js, Vue, Angular**, tích hợp với GitHub, và cho phép triển khai chỉ với một lệnh push.

📖 **Tài nguyên miễn phí để tìm hiểu:**
- 🔗 [Trang chủ Vercel](https://vercel.com/)
- 📖 [Tài liệu chính thức Vercel](https://vercel.com/docs)
- 🎥 [Hướng dẫn sử dụng Vercel](https://www.youtube.com/watch?v=sPmat30SE4k)
- 🌍 [Bài viết hay về Vercel](https://app.daily.dev/tags/vercel?ref=roadmapsh)

---

## 📌 Kết Luận

Serverless giúp **tự động hóa triển khai, giảm chi phí, dễ dàng mở rộng**. Các nền tảng phổ biến:
- **AWS Lambda**: Xử lý sự kiện không cần máy chủ.
- **Cloudflare**: CDN và bảo mật website.
- **Vercel**: Triển khai frontend nhanh chóng.

Việc lựa chọn nền tảng phụ thuộc vào **nhu cầu, công nghệ và chi phí** của bạn. 🚀

👉 **Bước tiếp theo:** Tìm hiểu về ***Provisioning***  quá trình cung cấp và cấu hình tài nguyên (máy chủ, mạng, lưu trữ, tài khoản) để hệ thống hoặc ứng dụng có thể hoạt động hiệu quả.
