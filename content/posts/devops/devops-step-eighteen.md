---
title: "Giám sát ứng dụng (Application Monitoring) 📊"
author: "Hoàng Dương"
date: "2025-02-25"
draft: false
description: "Giám sát ứng dụng là quá trình theo dõi, phân tích hiệu suất và phát hiện sự cố của phần mềm để đảm bảo hoạt động ổn định và tối ưu."
categories: ["DevOps"]
tags: ["devops"]
image: "images/devops/devops-step-eighteen.webp"
---

## 📊 Giám sát ứng dụng (Application Monitoring)

Giám sát ứng dụng là quá trình theo dõi và phân tích liên tục các ứng dụng phần mềm nhằm đảm bảo chúng hoạt động tối ưu, phát hiện sự cố và cung cấp những hiểu biết sâu sắc về hiệu suất của hệ thống. Việc giám sát bao gồm các chỉ số quan trọng như:

- ⏳ **Thời gian phản hồi**
- ❌ **Tỷ lệ lỗi**
- 🖥️ **Sử dụng tài nguyên (CPU, RAM, Disk)**
- 🔄 **Hiệu suất giao dịch**

Các công cụ giám sát ứng dụng giúp thu thập, phân tích dữ liệu để phát hiện bất thường, cảnh báo sớm các vấn đề tiềm ẩn, đồng thời cung cấp cái nhìn toàn diện về hành vi của ứng dụng. Nhờ đó, doanh nghiệp có thể chủ động xử lý sự cố, tối ưu hiệu suất và nâng cao trải nghiệm người dùng.

---

## 🔍 Jaeger - Công cụ tracing phân tán

Jaeger là một hệ thống giám sát phân tán mã nguồn mở do Uber phát triển, giúp theo dõi và khắc phục sự cố trong các hệ thống microservices phức tạp.

### 🔹 Tính năng chính:
- 🌐 **Theo dõi yêu cầu phân tán**
- 🔎 **Phân tích quan hệ giữa các dịch vụ**
- 📊 **Xác định nguyên nhân gốc rễ của vấn đề**
- 🛠️ **Hỗ trợ OpenTracing – dễ dàng tích hợp với các hệ thống khác**

### 🔹Ví dụ cài đặt Jaeger với Docker

```sh
docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 14250:14250 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.37
```

Sau khi cài đặt, tra cứu Jaeger UI tại http://localhost:16686

**📌 Tài nguyên tham khảo:**

[📖 Tài liệu Jaeger](https://www.jaegertracing.io/docs/1.37/)  
[🛠️ GitHub - jaegertracing](https://github.com/jaegertracing/jaeger)

---

## 🌎 New Relic - Giám sát hiệu năng ứng dụng

New Relic là một nền tảng quan sát đám mây cung cấp cái nhìn toàn diện về phần mềm và cơ sở hạ tầng. Nó hỗ trợ giám sát hiệu suất thời gian thực, phân tích dữ liệu và cảnh báo tự động.

### 🔹 Tính năng chính:
- 📈 **Theo dõi hiệu suất ứng dụng (APM)**
- 🔎 **Phân tích logs và truy vết lỗi**
- 🚀 **Theo dõi trải nghiệm người dùng trên web và mobile**
- 🤖 **AI-powered analytics – tự động phát hiện sự cố**

### 🔹Ví dụ cài đặt New Relic Agent trong Node.js
```
npm install newrelic --save
```

Sau đó, bạn cần thêm require('newrelic') ở dòng đầu tiên trong file main:

```javascript
require('newrelic');     #Thêm thư viện newrelic
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello, New Relic!'));
app.listen(3000, () => console.log('App running on port 3000'));
```

**📌 Tài nguyên tham khảo:**

[🌐 Trang web New Relic](https://newrelic.com/)  
[🎥 Bản demo nền tảng New Relic](https://www.youtube.com/watch?v=8kx7nRGVJRg)

---

## 🐶 Datadog - Giải pháp giám sát toàn diện

Datadog là một nền tảng giám sát và phân tích mạnh mẽ dành cho các ứng dụng quy mô lớn. Nó hỗ trợ nhiều lĩnh vực từ giám sát hạ tầng, hiệu suất ứng dụng đến quản lý logs và trải nghiệm người dùng.

### 🔹 Tính năng chính:
- 🔗 **400+ tích hợp với các công cụ DevOps**
- 📊 **Theo dõi toàn bộ hệ thống trên dashboard trực quan**
- ⚠️ **Thiết lập cảnh báo thông minh**
- 📡 **Hỗ trợ giám sát cloud-native**

### 🔹 Ví dụ vài đặt Datadog Agent

```sh
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=<YOUR_API_KEY> \
DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

Sau khi cài đặt, truy cập Datadog dashboard để xem các metric của bạn.

**📌 Tài nguyên tham khảo:**  

[🌐 Trang web Datadog](https://www.datadoghq.com/)  
[📖 Tài liệu Datadog](https://docs.datadoghq.com/)

---

## 🎯 Kết luận

Việc giám sát ứng dụng đóng vai trò quan trọng trong việc đảm bảo hiệu suất và độ tin cậy của hệ thống. Các công cụ như **Jaeger**, **New Relic** và **Datadog** cung cấp các giải pháp toàn diện giúp doanh nghiệp theo dõi, phân tích và tối ưu hóa hệ thống phần mềm một cách hiệu quả. Chọn công cụ phù hợp sẽ giúp bạn quản lý ứng dụng tốt hơn, phát hiện sớm lỗi và cải thiện trải nghiệm người dùng.

🚀 Hãy triển khai giám sát để tối ưu hóa hiệu suất ứng dụng của bạn!


👉 **Bước tiếp theo:** Tìm hiểu về ***Artifacts*** trong phát triển phần mềm, artifacts là các tệp hoặc sản phẩm được tạo ra trong quá trình phát triển và triển khai ứng dụng.
