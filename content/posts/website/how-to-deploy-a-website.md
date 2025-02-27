---
title: "Deploy Website lên hosting đơn giản nhất (HTML/CSS hoặc React/Vue.js) 🔥"
author: "Hoàng Dương"
date: "2025-02-26"
draft: false
description: "Cách up website lên Hosting thông qua File Manager và cPanel nhanh nhất từ A-Z. Bao gồm cả các framework như React hay Vue.js"
categories: ["Website"]
tags: ["website", "hosting"]
image: "images/website/upload-website-on-hosting.webp"
license: "VietNix"
---

## Cách up website lên Hosting thông qua File Manager và cPanel nhanh nhất từ A-Z 

---  

Việc upload website lên hosting là bước thiết yếu để đưa website của bạn hoạt động trên internet. Quá trình này không chỉ đơn giản là chuyển dữ liệu, mà còn liên quan đến việc đảm bảo mọi thứ hoạt động mượt mà và an toàn. Bài viết này sẽ giúp bạn hiểu rõ các bước cần thiết, từ chuẩn bị file và database, đến các công cụ hỗ trợ upload hiệu quả.  

---

## Điểm chính cần nắm  

Trước khi bắt tay vào việc upload website lên hosting, bạn cần lưu ý một số yếu tố quan trọng. Mình sẽ giúp bạn dễ dàng hiểu và nắm bắt các bước thực hiện:  

✅ **Bạn cần chuẩn bị gì khi upload website lên hosting**: Chuẩn bị file website, database, quyền truy cập control panel và phần mềm FTP như FileZilla.  

✅ **Các cách upload website lên hosting**: Chọn hosting uy tín, sau đó sử dụng File Manager, FTP, plugin WordPress, SSH hoặc nhờ hỗ trợ từ nhà cung cấp.  

✅ **Lý do cần upload website lên hosting**: Giúp công khai website, tăng bảo mật, cải thiện tốc độ và dễ quản lý.  

✅ **Bốn bước để upload web lên hosting**:  

1. Upload file website vào thư mục `public_html` qua File Manager hoặc FTP.  
2. Kiểm tra xem các file đã đúng vị trí chưa.  
3. Tạo database trên cPanel, import dữ liệu qua phpMyAdmin và cấu hình kết nối.  
4. Truy cập website để kiểm tra xem mọi thứ đã hoạt động ổn định chưa.  


## Cần chuẩn bị gì khi upload website lên hosting?

Để upload website lên hosting, trước tiên bạn cần phải chuẩn bị một số vấn đề sau đây:

- **File website**: Những file này có thể là toàn bộ dữ liệu bên trong phần `public_html` cũ hoặc file source code hay bản backup (sao lưu) dữ liệu mới nhất thay cho source code. 

> **📌 Lưu ý khi triển khai website React/Vue.js**
>
> Khi build một ứng dụng **React** hoặc **Vue.js**, ta không tải toàn bộ mã nguồn lên máy chủ,  
> mà chỉ cần upload **thư mục chứa các file tĩnh đã được build**.  
>  
> **🔹 Các bước build và nén tệp:**  
> - Chạy lệnh build:  
>   - **React:**  
>     ```sh
>     npm run build
>     ```
>   - **Vue.js:**  
>     ```sh
>     npm run build
>     ```
> - Sau khi build xong, thư mục output thường là `build/` (**React**) hoặc `dist/` (**Vue.js**).  
> - Nén thư mục `build` hoặc `dist` thành file ZIP trước khi tải lên máy chủ.  
>  
> **📤 Khi tải lên máy chủ:**  
> - Nếu dùng **cPanel**, có thể giải nén trực tiếp trong thư mục `public_html`.  
> - Nếu dùng **SSH/SFTP**, tải lên và giải nén bằng lệnh:  
>   ```sh
>   unzip build.zip -d /var/www/html/
>   ```
> - Đảm bảo **cấu hình máy chủ (Apache/Nginx)** để trỏ vào thư mục chứa file `index.html`.  


- **File database** (nếu có).
- **Truy cập control panel** của tài khoản hosting mới.
- **Phần mềm FTP client** như FileZilla.

Để tải trang web lên hosting, bạn cần truy cập control panel của tài khoản hosting bằng phần mềm FTP như FileZilla. Nếu trang web đã có, bạn có thể dễ dàng sao lưu và tải lên bằng tính năng sao lưu của CMS hoặc cPanel.

### Chọn nhà cung cấp hosting uy tín, tin cậy

Web Hosting chất lượng không chỉ đảm bảo tốc độ mà còn quyết định hiệu suất vận hành lâu dài của website. Vì vậy, việc lựa chọn nhà cung cấp hosting cần được thực hiện cẩn thận, dựa trên các tiêu chí sau:

- **Hỗ trợ trực tuyến**: Đảm bảo nhà cung cấp có dịch vụ hỗ trợ khách hàng 24/7, giúp bạn nhanh chóng giải quyết sự cố.
- **Quyền kiểm soát tài khoản hosting**: Bạn cần được cung cấp toàn quyền quản lý tài khoản hosting, bao gồm quyền truy cập vào cPanel hoặc các công cụ tương đương.
- **Khả năng mở rộng**: Hosting nên có khả năng nâng cấp tài nguyên khi nhu cầu của bạn tăng cao, như dung lượng lưu trữ, băng thông hoặc số lượng tên miền.
- **Chính sách hoàn tiền minh bạch**: Các chính sách hoàn tiền linh hoạt sẽ giúp bạn an tâm hơn khi thử nghiệm dịch vụ.
- **Dịch vụ cộng thêm miễn phí**: Ưu tiên nhà cung cấp hỗ trợ thêm các tiện ích như SSL miễn phí, sao lưu định kỳ hoặc dịch vụ di chuyển website.
- **Đăng ký tên miền được công nhận bởi ICANN**: Để bảo vệ thương hiệu của bạn, hãy chọn nhà cung cấp tên miền uy tín và được chứng nhận bởi ICANN.

> **Lưu ý**: Hãy tìm hiểu kỹ về đánh giá của người dùng và uy tín của nhà cung cấp thông qua các diễn đàn hoặc trang đánh giá trước khi đưa ra quyết định. Điều này sẽ giúp bạn chọn được dịch vụ phù hợp nhất với nhu cầu phát triển website.
 
### Lựa chọn phương pháp upload website lên hosting

Có 5 phương pháp chính để upload website lên hosting, tùy thuộc vào nhu cầu và công cụ bạn sử dụng:

####  Sử dụng công cụ quản lý file (File Manager)

Là công cụ quản lý file trực tiếp trên nền tảng web của hosting, thường được tích hợp sẵn trong cPanel hoặc các trình quản lý hosting khác. 

**Ưu điểm:**
- Miễn phí.
- Dễ dàng sử dụng.

**Nhược điểm:**
- Hạn chế dung lượng file tải lên (thường tối đa 256 MB).
- Chỉ giải nén được các file nhỏ hơn dung lượng này.

> **Lưu ý**: Khi dùng File Manager, bạn chỉ có thể tải hoặc giải nén file có dung lượng tối đa 256MB. Nếu muốn tải file lớn hơn, sử dụng FTP và giải nén qua SSH sẽ là lựa chọn tối ưu.

![Truy cập File Manager](https://image.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-16.webp)

<p align="center"><em>Hình 1: Truy cập vào File Manager</em></p>


####  Sử dụng giao thức truyền tải file (FTP)

Giao thức FTP (File Transfer Protocol) cho phép bạn tải file lên hosting thông qua phần mềm FTP client như FileZilla. Đây là phương pháp hiệu quả và không giới hạn dung lượng file tải lên. 

**Ưu điểm:**
- Không giới hạn dung lượng tải lên.
- Tải file lớn nhanh chóng và tiện lợi.

**Nhược điểm:**
- Cần cài đặt phần mềm FTP client.
- Cần thông tin đăng nhập FTP từ hosting.
- Bảo mật không cao, có thể sử dụng SFTP để an toàn hơn.

![Thông tin FPT](https://image.vietnix.vn/wp-content/uploads/2023/11/locating-ftp-details-4.webp)

<p align="center"><em>Hình 2: Thông tin FPT</em></p>

####  Sử dụng Plugin Di Chuyển WordPress

Nếu bạn sử dụng WordPress, các plugin như All in One WP Migration có thể giúp bạn di chuyển toàn bộ website một cách tự động.

**Ưu điểm:**
- Dễ sử dụng, không cần kiến thức kỹ thuật cao.
- Kéo thả file đơn giản.

**Nhược điểm:**
- Giới hạn dung lượng file tải lên (thường là 256 MB).
- Với file lớn hơn, cần chuyển sang FTP và SSH.

> **Lưu ý**: Plugin này có giới hạn dung lượng, nếu muốn tải file lớn, bạn cần chuyển sang FTP và giải nén qua SSH. Sau khi upload, nhớ chuyển dữ liệu trong thư mục con ra ngoài `public_html` để website hoạt động chính xác.

![Sử dụng WordPress Migration Plugin](https://image.vietnix.vn/wp-content/uploads/2023/11/img_20230304150023-8.webp)

<p align="center"><em>Hình 3: Sử dụng WordPress Migration Plugin</em></p>

####  Sử dụng SSH (Secure Shell)

SSH là cách tải và quản lý file qua dòng lệnh, phù hợp với những file lớn hoặc yêu cầu tốc độ cao.

**Ưu điểm:**
- Nhanh chóng, không giới hạn dung lượng.
- Có thể giải nén file trực tiếp trên server.

**Nhược điểm:**
- Yêu cầu kỹ năng sử dụng lệnh cơ bản và quyền truy cập SSH từ nhà cung cấp hosting.

![Sử dụng SSH upload website](https://image.vietnix.vn/wp-content/uploads/2024/09/Su-dung-SSH-upload-website.webp)

<p align="center"><em>Hình 4: Sử dụng SSH upload website</em></p>

####  Import Site – Trình nhập website tự động

Một số nhà cung cấp dịch vụ hosting cung cấp công cụ **Import Site** giúp tải và giải nén website vào thư mục `public_html` một cách nhanh chóng.

**Ưu điểm:**
- Quá trình tải lên nhanh chóng và dễ dàng.
- Không cần nhiều kiến thức kỹ thuật.

**Nhược điểm:**
- Phụ thuộc vào nhà cung cấp hosting có hỗ trợ công cụ này.
- Không phải nhà cung cấp hosting nào cũng cung cấp công cụ này.

> **Gợi ý**: Kiểm tra với nhà cung cấp hosting xem họ có hỗ trợ công cụ nhập trang web hay không.

![Tool nhập website](https://image.vietnix.vn/wp-content/uploads/2023/11/import-website-tool-2.webp)

<p align="center"><em>Hình 5: Tool nhập website</em></p>

####  Nhờ sự hỗ trợ từ nhà cung cấp hosting

Hầu hết các nhà cung cấp hosting đều có dịch vụ hỗ trợ di chuyển website, đặc biệt khi bạn chuyển từ dịch vụ hosting cũ sang nhà cung cấp mới.

**Ưu điểm:**
- Tiết kiệm thời gian và tránh sai sót kỹ thuật.
- Được thực hiện bởi đội ngũ chuyên gia.

**Nhược điểm:**
- Có thể mất phí nếu nhà cung cấp không hỗ trợ miễn phí.
- Thời gian xử lý phụ thuộc vào đội ngũ hỗ trợ.

> **Gợi ý**: Hãy kiểm tra chính sách hỗ trợ di chuyển website của nhà cung cấp hosting trước khi yêu cầu dịch vụ.

![Nhờ sự hỗ trợ từ nhà cung cấp hosting](https://image.vietnix.vn/wp-content/uploads/2024/09/Nho-su-ho-tro-tu-nha-cung-cap-hosting.webp)

<p align="center"><em>Hình 6: Nhờ sự hỗ trợ từ nhà cung cấp hosting</em></p>

> 📌 **Lưu ý sau khi upload website lên hosting**
>  
> - **Di chuyển toàn bộ dữ liệu từ thư mục con (nếu có) ra ngoài `public_html`** để website hoạt động chính xác.  
> - **Kiểm tra lại cấu trúc file và kết nối database (nếu có)** để tránh lỗi khi vận hành.  
> - **Chọn phương pháp phù hợp nhất** dựa trên kích thước file, nền tảng website và khả năng kỹ thuật của bạn.  

---

## Lý do cần upload website lên Hosting

Việc upload website lên hosting không chỉ là bước cần thiết để đưa website của bạn ra công chúng, mà còn mang lại nhiều lợi ích quan trọng giúp website hoạt động ổn định, bảo mật và hiệu quả. Dưới đây là những lý do bạn nên thực hiện việc này:

### Xuất bản website và tiếp cận toàn cầu

Khi bạn upload website lên hosting, website sẽ trở nên công khai và có thể truy cập từ bất kỳ đâu trên thế giới qua tên miền (domain) của bạn. Nếu không làm điều này, chỉ riêng bạn mới có thể truy cập website từ máy tính cá nhân.

### Bảo mật và an toàn dữ liệu

Hosting chuyên nghiệp mang lại những biện pháp bảo mật mạnh mẽ, chẳng hạn như chứng chỉ SSL, tường lửa và các công cụ bảo vệ dữ liệu khác. Điều này giúp đảm bảo an toàn cho website và cả dữ liệu thương hiệu khỏi các nguy cơ tấn công, mất mát hoặc xâm nhập dữ liệu, một vấn đề mà việc lưu trữ website trên máy tính cá nhân sẽ khó đảm bảo được.

### Tăng tốc độ và hiệu suất Website

Các máy chủ hosting được tối ưu để xử lý lưu lượng truy cập lớn và cung cấp tốc độ internet nhanh chóng, giúp tăng cường hiệu suất tải trang của website. Điều này có nghĩa là người dùng sẽ có trải nghiệm mượt mà hơn, đồng thời giảm thiểu tình trạng website bị "lag" hoặc tải chậm, một yếu tố quan trọng trong việc giữ chân người truy cập.

![Tăng tốc độ và hiệu suất Website](https://image.vietnix.vn/wp-content/uploads/2024/09/Tang-toc-do-va-hieu-suat-Website.webp)

<p align="center"><em>Hình 7: Tăng tốc độ và hiệu suất Website</em></p>

### Tính ổn định và tin cậy

Khi website được lưu trữ trên hosting, bạn không phải lo lắng về việc duy trì phần cứng hay kết nối mạng. Các nhà cung cấp hosting sẽ đảm bảo server luôn hoạt động ổn định với thời gian uptime cao, giúp website của bạn luôn sẵn sàng phục vụ người dùng mà không gặp phải sự cố downtime kéo dài.

### Quản lý website dễ dàng và tiện lợi

Các nhà cung cấp hosting cung cấp giao diện quản lý thân thiện và dễ sử dụng, giúp bạn dễ dàng theo dõi, tối ưu và bảo trì website. Từ việc sao lưu dữ liệu, nâng cấp phần mềm cho đến việc tối ưu hóa hiệu suất, tất cả đều trở nên đơn giản hơn khi bạn sử dụng dịch vụ hosting chuyên nghiệp.

### Tính mở rộng và phát triển lâu dài

Hosting không chỉ phục vụ website trong giai đoạn đầu, mà còn hỗ trợ khả năng mở rộng khi website của bạn phát triển. Nếu lưu trữ trên máy tính cá nhân, bạn sẽ gặp khó khăn khi website tăng trưởng về lưu lượng truy cập hay yêu cầu về tài nguyên. Hosting chuyên nghiệp sẽ giúp bạn dễ dàng nâng cấp tài nguyên mà không phải lo lắng về việc mất dữ liệu hay gián đoạn dịch vụ.

![Tính mở rộng và phát triển lâu dài](https://image.vietnix.vn/wp-content/uploads/2024/09/Tinh-mo-rong-va-phat-trien-lau-dai.webp)

<p align="center"><em>Hình 8: Tính mở rộng và phát triển lâu dài</em></p>

---

Tóm lại, việc upload website lên hosting mang lại những lợi ích vượt trội về bảo mật, hiệu suất, tính ổn định và khả năng quản lý, giúp website của bạn hoạt động hiệu quả và bền vững. Đây là bước quan trọng để không chỉ bảo vệ dữ liệu mà còn tạo ra một nền tảng vững chắc để phát triển website trong tương lai. Vì vậy, nếu bạn muốn website của mình hoạt động trơn tru và dễ dàng truy cập từ mọi nơi, việc upload lên hosting là điều không thể thiếu.

---

## Bước 1: Chọn cách upload file website lên host

### Cách 1: Upload website lên hosting bằng File Manager qua cPanel
### Cách 2: Upload website lên hosting bằng FTP client

Sau khi bạn đã lựa chọn xong cách để upload, dưới đây là hướng dẫn cách upload website lên hosting đơn giản, bạn có thể tham khảo.

---

---Cách 1: Upload website lên hosting bằng File Manager qua cPanel--- (Dễ nhất)

Truy cập cPanel của tài khoản hosting và làm theo hướng dẫn dưới đây:

Bước 1: Click vào icon **File Manager**, đặt bên dưới mục **Files**.

**Chọn File Manager**  
*Hình ảnh minh họa: Chọn File Manager*

![Chọn File Manager](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-1.webp)

<p align="center"><em>Chọn File Manager</em></p>

Bước 2: Trong **File Manager**, mở thư mục `public_html`.

**Mở thư mục public_html**  
*Hình ảnh minh họa: Mở thư mục public_html*

![Mở thư mục public_html](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-2.webp)

<p align="center"><em>Mở thư mục public_html</em></p>

Bước 3: Chọn **Upload** sau khi truy cập vào thư mục `public_html`.

**Chọn Upload**  
*Hình ảnh minh họa: Chọn Upload*

![Chọn Upload](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-3.webp)

<p align="center"><em>Chọn Upload</em></p>

Bước 4: Chọn **Select File** để chọn từng file hoặc kéo thả vào vùng nhận file.

**Chọn file**  
*Hình ảnh minh họa: Chọn file*

![Chọn file](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-4.webp)

<p align="center"><em>Chọn file</em></p>

Bước 5: Trong ví dụ này, mình kéo thả file `wordpress.zip`.

**Chọn file zip wordpress**  
*Hình ảnh minh họa: Chọn file zip wordpress (hoặc file dist.zip/build.zip)*

![Chọn file zip wordpress](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-5.webp)

<p align="center"><em>Chọn file zip wordpress</em></p>

Bước 6: Khi upload xong, quay lại **File Manager** để thấy file archive đã xuất hiện trong thư mục `public_html`. Click chuột phải và nhấn **Extract** để giải nén file archive.

**Extract file**  
*Hình ảnh minh họa: Extract file*

![Extract file](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-6.webp)

<p align="center"><em>Extract file</em></p>

Bước 7: Chọn vị trí file archive cần extract, ở ví dụ này sẽ lưu vào `/public_html`.

**Chọn vị trí file cần extract**  
*Hình ảnh minh họa: Chọn vị trí file cần extract*

![Chọn vị trí file cần extract](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-7.webp)

<p align="center"><em>Chọn vị trí file cần extract</em></p>

Bước 8: Sau khi giải nén file, bạn có thể xem các file đã được giải nén trong thư mục `public_html`. Đây là thư mục gốc của website.

**Quay lại thư mục ban đầu để xem**  
*Hình ảnh minh họa: Quay lại thư mục ban đầu để xem*

![Quay lại thư mục ban đầu để xem](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-8.webp)

<p align="center"><em>Quay lại thư mục ban đầu để xem</em></p>

Bước 9: Trang web đã tải xong. Bạn có thể truy cập vào trang web bằng cách nhập URL vào trình duyệt.

**Màn hình chọn ngôn ngữ trong quá trình cài đặt WordPress**  ***(Nếu có)***



---

---Cách 2: Upload website lên hosting bằng FTP client---

Một số người dùng thích tải trang web của họ lên dịch vụ hosting qua **FTP**, ví dụ: **FileZilla, SmartFTP, CoreFTP** hoặc bất kỳ phần mềm nào khác. Trong các hướng dẫn sau, mình sẽ sử dụng **FileZilla**.

Những lưu ý trước khi upload website lên hosting:

- **Kiến thức và kỹ năng của bạn:** Nếu bạn không có nhiều kiến thức về hosting, **File Manager** sẽ dễ sử dụng hơn. Nếu bạn thành thạo, **FTP client** sẽ giúp tải lên nhanh hơn.
- **Kích thước của website:** Nếu website có dung lượng lớn, **FTP client** sẽ thuận tiện hơn vì không giới hạn dung lượng tải lên.
- **Yêu cầu đặc thù của website:** Nếu website yêu cầu cấu hình server đặc biệt, bạn nên hỏi nhà cung cấp hosting để chọn cách upload phù hợp.

Bước 1: Trước tiên, bạn cần lấy thông tin FTP thông qua **FTP Access**. Nếu quên mật khẩu, bạn có thể đặt mật khẩu mới qua phần **Change account password**.

**Lấy thông tin qua FTP Access**  
*Hình ảnh minh họa: Lấy thông tin qua FTP Access*

![Lấy thông tin qua FTP Access](https://image.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-9.webp)

<p align="center"><em>Lấy thông tin qua FTP Access</em></p>

Bước 2: Mở **FileZilla**, điền thông tin FTP để truy cập và nhấn **Quickconnect**.

**Chọn Quickconnect**  
*Hình ảnh minh họa: Chọn Quickconnect*

![Chọn Quickconnect](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-10.webp)

<p align="center"><em>Chọn Quickconnect</em></p>

Bước 3: Sau khi kết nối với FileZilla, tìm dữ liệu trang web và kéo chúng từ bên trái của phần mềm sang bên phải, thư mục đích là `public_html`. Bạn cần giải nén file archive trước, vì FTP không có chức năng giải nén.

**Kéo thả dữ liệu từ bên trái của phần mềm sang bên phải**  
*Hình ảnh minh họa: Kéo thả dữ liệu từ bên trái của phần mềm sang bên phải*

![Kéo thả dữ liệu từ bên trái của phần mềm sang bên phải](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-11.webp)

<p align="center"><em>Kéo thả dữ liệu từ bên trái của phần mềm sang bên phải</em></p>


Bước 4: Tương tự, bạn có thể upload file nén qua **FTP** bằng cách kéo thả từ trái sang phải. Sau đó, giải nén chúng thông qua **File Manager**.

**Upload file nén qua FTP**  
*Hình ảnh minh họa: Upload file nén qua FTP*

![Upload file nén qua FTP](https://static.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-12.webp)

<p align="center"><em>Upload file nén qua FTP</em></p>

Bước 5: Sau khi tải trang web lên hosting, bạn có thể truy cập trang web bằng cách nhập URL vào trình duyệt. Bạn sẽ thấy trang cài đặt mặc định của website và có thể tùy chỉnh trang này để phù hợp với nhu cầu của mình.

---

## Bước 2: Kiểm tra xem file đã ở trong thư mục public_html hay chưa

Sau khi upload website lên hosting, bước đầu tiên bạn cần làm là kiểm tra xem các file đã được tải đầy đủ vào thư mục `public_html` chưa. Bạn có thể mở thư mục `public_html` và kiểm tra xem tất cả các file đã nằm trong đó chưa. Nếu bạn tạo ra thư mục mới sau khi upload và giải nén website backup, người dùng sẽ phải truy cập theo đường dẫn dạng `example.com/something` thay vì `example.com`. Để khắc phục điều này, bạn có thể sử dụng **File Manager** hoặc **FTP** theo các bước sau:

1. Truy cập vào thư mục chứa các file của website.
2. Chọn toàn bộ các file và nhấn chuột phải, sau đó chọn nút **Move**.
3. Lựa chọn thư mục đích là `public_html` và nhấn **Proceed**.

Nếu website của bạn đã được vận hành một thời gian, bạn cũng cần phải upload **database** lên hosting nếu chưa thực hiện.

Sau khi đã đảm bảo các file đã được di chuyển đúng vào thư mục `public_html`, bạn có thể kiểm tra website bằng cách mở trình duyệt và truy cập vào tên miền của mình. Nếu tên miền chưa được trỏ đúng, bạn có thể sử dụng các phương pháp sau để kiểm tra và sửa lỗi DNS:

- Sửa **file hosts** trên máy tính để giả lập thay đổi DNS.
- Sử dụng các **công cụ online** để kiểm tra tên miền.
- Cài đặt **plugin trình duyệt** để tạo file host ảo.

Ngoài ra, nếu bạn cần di chuyển website từ thư mục con lên thư mục gốc (`public_html`), bạn có thể sử dụng **File Manager** hoặc **FTP** để thực hiện. Và bạn đừng quên tải lại **cơ sở dữ liệu** lên hosting nếu cần thiết.

---

## Bước 3: Tiến hành upload database lên website hosting

>Thực hiện bước này khi website của người dùng đã có sẵn ***database***. Nếu không, bạn có thể bỏ qua bước này.

### Tạo database trên cPanel

Tạo một database mới tại section **MySQL Databases**. Khi tạo database bạn cần điền và ghi chú lại những thông số database như sau:

- **MySQL Database**
- **MySQL User**
- **MySQL Host**
- **MySQL Password**

![Tạo database mới](https://image.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-13.webp)

<p align="center"><em>Tạo database mới</em></p>

### Di chuyển vào phpMyAdmin của database

Khi sử dụng **phpMyAdmin** để quản lý database, hãy **import database MySQL**. Nếu bạn muốn upload vào một database có sẵn, hãy xóa dữ liệu trước để tránh lỗi khi tải lên từ máy tính.

![Di chuyển vào phpMyAdmin](https://image.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-14.webp)

<p align="center"><em>Di chuyển vào phpMyAdmin</em></p>

### Di chuyển vào tab Import và upload dữ liệu vào database

Nếu là lần đầu tạo database, chỉ cần vào tab **Import** để upload dữ liệu vào database trống. Bạn đã có một file SQL từ bản sao lưu của trang web, có thể là file dạng text với đuôi `.sql` hoặc dạng nén như `.sql.zip` hay `.sql.gz`. Hãy nhấn nút **Choose File** để chọn file cơ sở dữ liệu và sau đó bấm nút **Go** để bắt đầu quá trình tải lên. Khi **phpMyAdmin** hoàn tất và hiển thị thông báo *Import has been successfully finished, 302 queries executed*, có nghĩa là quá trình tải lên cơ sở dữ liệu đã hoàn tất.

![Import dữ liệu vào database](https://image.vietnix.vn/wp-content/uploads/2023/11/upload-website-len-hosting-15.webp)

<p align="center"><em>Import dữ liệu vào database</em></p>

### Cập nhật file cấu hình để kết nối website và database

Sau khi tải database lên server, bạn cần mở **file cấu hình PHP** script để điền thông tin như host, tên database, tên người dùng và mật khẩu. File cấu hình có thể có tên và vị trí khác nhau tùy thuộc vào phần mềm bạn sử dụng. Ví dụ, với **WordPress**, file cấu hình là `wp-config.php` và nằm trong thư mục chứa **WordPress** (thường là `public_html`).

> ⚠ **Lưu ý:**
> - Nếu cơ sở dữ liệu của bạn có kích thước lớn, hãy cân nhắc chia nhỏ database thành nhiều file để quá trình tải lên diễn ra nhanh chóng hơn.
> - Nếu database chứa các ký tự đặc biệt, nhớ chuyển đổi chúng sang định dạng **ASCII** trước khi thực hiện upload.
> - Trong trường hợp gặp lỗi khi import, bạn cần kiểm tra xem database có bị hỏng hay không. Nếu bị lỗi, hãy tạo lại một cơ sở dữ liệu mới và thử lại.
> - Cuối cùng, sau khi upload xong, đừng quên kiểm tra website của bạn để đảm bảo mọi thứ hoạt động bình thường.

### Cập nhật file cấu hình để kết nối website và database

Sau khi tải database lên server, bạn cần mở file cấu hình PHP script để điền thông tin như **host**, **tên database**, **tên người dùng** và **mật khẩu**.  

File cấu hình có thể có tên và vị trí khác nhau tùy thuộc vào phần mềm bạn sử dụng. Ví dụ, với **WordPress**, file cấu hình là `wp-config.php` và nằm trong thư mục chứa WordPress (thường là `public_html`).

---

## Bước 4: Kiểm tra website đã hoạt động ổn định hay chưa

Để đảm bảo website của bạn hoạt động ổn định sau khi tải lên và trỏ tên miền, bạn cần thực hiện một số bước kiểm tra quan trọng:

### 🔍 Kiểm tra truy cập website
- **Truy cập bằng tên miền hoặc địa chỉ IP:** Nếu bạn có thể truy cập thành công, website đã hoạt động ổn định.
- **Chờ DNS cập nhật:** Nếu tên miền vừa được cập nhật, bạn có thể cần đợi khoảng **24 giờ** để DNS được quảng bá rộng rãi.
- **Kiểm tra ngay lập tức bằng:**
  - 🖥️ **Sử dụng file host:** Chỉnh sửa file host trên máy tính để mô phỏng thay đổi DNS.
  - 🌐 **Công cụ online:** Kiểm tra website bằng các dịch vụ kiểm tra DNS trực tuyến.
  - 🔌 **Plugin browser:** Cài đặt plugin giúp tạo file host ảo để kiểm tra các thay đổi DNS.

### 🛠️ Kiểm tra các chức năng của website
- Thử truy cập các trang khác nhau, kiểm tra liên kết.
- Kiểm tra xem các tính năng của website có hoạt động đúng không.

### ⚡ Kiểm tra tốc độ tải trang
- Sử dụng các công cụ như **Google PageSpeed Insights, GTmetrix** để kiểm tra hiệu suất.

### 🚨 Kiểm tra các lỗi trên website
- **Lỗi 404:** Trang không tìm thấy.
- **Lỗi 500:** Lỗi máy chủ hosting.
- **Lỗi 503:** Máy chủ đang bảo trì.

### 🌍 Kiểm tra trên nhiều trình duyệt & thiết bị
- Dùng **Chrome, Firefox, Safari, Edge** trên **máy tính, điện thoại, máy tính bảng**.

### ⏳ Kiểm tra vào các thời điểm khác nhau trong ngày
- Website có thể hoạt động khác nhau vào những thời điểm khác nhau.

👉 **Nếu phát hiện lỗi nhưng không biết cách xử lý, hãy liên hệ với nhà cung cấp hosting để được hỗ trợ.** 🚀 

---

## 📌 Lời kết

Upload website lên hosting là một bước quan trọng để website của bạn có thể hoạt động ổn định trên môi trường trực tuyến. Bằng cách chuẩn bị đúng đắn và thực hiện theo các bước hướng dẫn, bạn sẽ đảm bảo rằng website của mình luôn sẵn sàng phục vụ người dùng một cách hiệu quả. 

💡 Nếu bạn có bất kỳ câu hỏi nào hoặc cần hỗ trợ thêm, hãy để lại câu hỏi trong phần bình luận dưới đây. Mình sẽ sớm giúp bạn tìm ra lời giải đáp.  

Cảm ơn bạn đã theo dõi bài viết 🚀
