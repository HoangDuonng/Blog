---
title: "Tiêu đề bài viết"
author: "Hoàng Dương"
date: "YYYY-MM-DD"
draft: false
description: "Mô tả ngắn gọn về nội dung bài viết, thường là 1-2 câu để hiển thị trong SEO và preview."
categories: ["Tên Category"]
tags: ["tag1", "tag2", "tag3"]
image: "images/category-name/image-name.webp"
license: "ABC" # Optional
---

## Tiêu đề chính của bài viết

Đoạn giới thiệu ngắn gọn về chủ đề, có thể sử dụng **bold text** để nhấn mạnh các từ khóa quan trọng.

---

## I. Phần chính đầu tiên

Nội dung phần này mô tả chi tiết về chủ đề. Có thể sử dụng:

- **Danh sách có dấu đầu dòng** với các điểm quan trọng
- **Bold text** để nhấn mạnh
- _Italic text_ để làm nổi bật thuật ngữ

### 1. Tiểu mục 1

Nội dung chi tiết cho tiểu mục.
Có thể sử dụng bảng để so sánh hoặc liệt kê: #Optional

| Kỹ thuật          | Giải thích                     | Nguồn tham khảo              |
| ----------------- | ------------------------------ | ---------------------------- |
| **Tên kỹ thuật**  | Mô tả chi tiết về kỹ thuật này | Link hoặc tài liệu tham khảo |
| **Kỹ thuật khác** | Mô tả về kỹ thuật khác         | Nguồn tham khảo              |

**Tiêu đề cho code block hoặc ví dụ:**

```
# Code example
# Đây là ví dụ về code block
# Có thể là Dockerfile, script, config, v.v.
```

---

### 2. Tiểu mục 2

Nội dung cho tiểu mục thứ hai. Có thể chèn hình ảnh:

<p align="center">
  <img src="https://example.com/image.jpg" alt="Mô tả hình ảnh">
</p>
<p align="center"><em>Chú thích cho hình ảnh</em></p>

Hoặc sử dụng emoji để làm nổi bật: 🚀 ⚡ 🔥 💡

---

## II. Phần chính thứ hai

Nội dung phần này tiếp tục phát triển chủ đề.

### 1. Tiểu mục trong phần II

- Điểm 1
- Điểm 2
- Điểm 3

---

## Ghi chú triển khai

- **Khi áp dụng vào dự án của bạn**, hãy lưu ý các điểm quan trọng:
  - Điểm cần lưu ý 1
  - Điểm cần lưu ý 2
  - Điểm cần lưu ý 3
- **Best practices**: Mô tả các best practices liên quan
- **Troubleshooting**: Các vấn đề thường gặp và cách xử lý

---

## 🎯 Lời kết

Tóm tắt lại nội dung chính và kêu gọi hành động hoặc khuyến khích người đọc thử nghiệm. Có thể sử dụng emoji để tạo cảm giác thân thiện. 🚀😊

---

## Cấu trúc Frontmatter (YAML)

```yaml
---
title: "Tiêu đề bài viết" # Bắt buộc
author: "Hoàng Dương" # Bắt buộc
date: "YYYY-MM-DD" # Bắt buộc, format: 2025-11-29
draft: false # Bắt buộc, true = bản nháp, false = publish
description: "Mô tả ngắn gọn" # Bắt buộc, cho SEO
categories: ["Tên Category"] # Bắt buộc, array
tags: ["tag1", "tag2"] # Bắt buộc, array
image: "images/category/image.webp" # Bắt buộc, đường dẫn từ static/
license: "DevOpsVN" # Tùy chọn
---
```

## Quy tắc viết nội dung

1. **Tiêu đề**: Sử dụng `##` cho tiêu đề chính, `###` cho tiểu mục
2. **Horizontal rules**: Sử dụng `---` để phân cách các phần lớn
3. **Bảng**: Sử dụng markdown table format với alignment
4. **Code blocks**: Sử dụng triple backticks với language identifier nếu cần
5. **Hình ảnh**: Sử dụng HTML `<p align="center">` để căn giữa hình ảnh
6. **Emoji**: Có thể sử dụng emoji để làm nổi bật (🚀 ⚡ 🔥 💡 🎯)
7. **Bold/Italic**: Sử dụng `**bold**` và `*italic*` để nhấn mạnh
8. **Lists**: Sử dụng `-` cho danh sách không đánh số, `1.` cho danh sách đánh số

## Cấu trúc thư mục

- Bài viết được lưu trong: `content/posts/{category}/{filename}.md`
- Hình ảnh được lưu trong: `static/images/{category}/{image-name}.webp`
- Category phải khớp với thư mục trong `content/categories/`

## Ví dụ về các loại bài viết

### 1. Bài viết kỹ thuật (Docker, DevOps)

- Có nhiều code blocks
- Có bảng so sánh kỹ thuật
- Có phần "Ghi chú triển khai"
- Có nhiều tiểu mục với số thứ tự

### 2. Bài viết hướng dẫn (Website, Tutorial)

- Có hình ảnh minh họa
- Có các bước hướng dẫn rõ ràng
- Có phần "Lời kết" với emoji
- Sử dụng emoji để làm nổi bật các phần

### 3. Bài viết giới thiệu (Intro)

- Có phần giới thiệu ngắn gọn
- Có các phần chính với tiêu đề rõ ràng
- Có ví dụ code đơn giản
- Có lời kết và kêu gọi theo dõi

###

- Lệnh chạy ứng dụng
  hugo server -D
  hugo --cleanDestinationDir
  hugo --minify --cleanDestinationDir
