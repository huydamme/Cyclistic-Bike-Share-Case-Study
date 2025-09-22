# Cyclistic-Bike-Share-Case-Study
Google Data Analytics Capstone Project

---

## 📌 Tóm tắt bối cảnh Case Study: *Cyclistic Bike-Share*

Công ty Cyclistic muốn phân tích sự khác biệt hành vi giữa khách vãng lai và khách thành viên, từ đó thiết kế chiến lược marketing thuyết phục khách vãng lai trở thành thành viên thường niên, vì nhóm này mang lại lợi nhuận cao hơn.

---

## 📌 Business Task (Nhiệm vụ phân tích)

**Vấn đề cần giải quyết:**
Cyclistic muốn tăng số lượng **annual members** vì nhóm này mang lại lợi nhuận cao hơn so với **casual riders**. Để thiết kế một chiến lược marketing hiệu quả, cần hiểu rõ **sự khác biệt trong hành vi sử dụng xe** giữa hai nhóm khách hàng.

---

## 📌 Prepare 

### 1. Nguồn dữ liệu

* **Data source:** Public dataset của **Motivate International Inc.** (chủ sở hữu hệ thống Divvy Bikes tại Chicago).
* **Thời gian sử dụng:** Quý 1 năm 2019 và Quý 1 năm 2020.
* **Định dạng:** CSV file.
* **Lưu trữ:** Tải về và lưu trữ trong máy cá nhân, sẽ import vào **RStudio** để phân tích.

---

### 2. Tổ chức dữ liệu

* Mỗi file tương ứng với một quý (Q1).
* Mỗi dòng = 1 chuyến đi (trip).
* Các cột bao gồm (có thể thay đổi chút giữa các file):

  * `ride_id` hoặc `trip_id` (mã chuyến đi).
  * `started_at` (thời gian bắt đầu).
  * `ended_at` (thời gian kết thúc).
  * `start_station_name`, `end_station_name`.
  * `member_casual` (phân loại khách hàng: **casual** hoặc **member**).

---

## 📌 Process 

### 1. Công cụ sử dụng

* **RStudio** với các thư viện chính:

  * `tidyverse` (xử lý dữ liệu & visualization cơ bản).
  * `lubridate` (xử lý ngày giờ).
  * `janitor` (dọn tên cột).
* Lý do chọn RStudio: Hỗ trợ thao tác dữ liệu lớn, dễ lập trình pipeline và trực quan hóa.

---

### 2. Các bước xử lý dữ liệu 
* Cyclistic Bike-Share Case Study.R

---

## 📊 Analysis Summary

1. Casual riders có xu hướng đi lâu hơn nhưng ít thường xuyên.
2. Members đi nhiều chuyến hơn, đặc biệt vào ngày thường (commuting).
3. Casual riders thích cuối tuần, có xu hướng dùng cho giải trí.


# Các visual nên tạo (và vì sao)

1. **Bar chart — Số chuyến đi theo ngày trong tuần (so sánh member vs casual)**
   → Cho thấy khách đi nhiều vào ngày nào; giúp minh họa việc *members đi nhiều ngày thường (commute) còn casual tập trung cuối tuần (leisure)*.
2. **Line/Bar — Thời lượng chuyến đi trung bình theo ngày trong tuần (member vs casual)**
   → Trình bày khác biệt về thời lượng — casual có thể có trip dài hơn/shorter.
3. **Heatmap — Số chuyến theo giờ trong ngày × ngày trong tuần, facet theo member\_casual**
   → Hiện rõ pattern theo giờ (rush-hours vs leisure hours). Rất thuyết phục cho marketing & ops.
4. **Boxplot / Violin — Phân phối ride\_length theo nhóm**
   → Cho thấy phân phối, median, outliers; dùng để giải thích rào cản (ví dụ nhiều casual có trip dài bất thường).
5. **Top N start-stations (bar chart) phân theo nhóm**
   → Hiển thị nơi casual xuất phát (tourist hubs) vs nơi member xuất phát (khu văn phòng, ga tàu) — rất hữu dụng cho targeting.

---

## 📌 Kết luận tổng quan từ phân tích

* **Casual riders** có xu hướng:

  * Đi xe **lâu hơn** (ride\_length dài hơn).
  * Thường sử dụng vào **cuối tuần** (giải trí, du lịch).
  * Hay xuất phát từ các **trạm trung tâm, gần điểm du lịch**.

* **Annual members**:

  * Chuyến đi **ngắn hơn nhưng tần suất nhiều hơn**.
  * Chủ yếu sử dụng vào **ngày thường** (đi làm/đi học).
  * Hay sử dụng từ các **trạm gần khu dân cư và văn phòng**.

→ Điều này cho thấy **hai nhóm có hành vi rất khác nhau** (giải trí vs. đi làm thường xuyên).

---

## 📌 3 khuyến nghị chính 

1. **Thiết kế gói membership linh hoạt cho casual riders**

   * Ví dụ: “Weekend Pass → Annual Upgrade”, hoặc “Summer Pass → Annual Membership”.
   * Truyền thông nhấn mạnh rằng membership vẫn phù hợp cho nhu cầu **giải trí cuối tuần**, không chỉ cho commuter.

2. **Tập trung marketing tại các trạm du lịch và hotspot casual riders hay bắt đầu chuyến đi**

   * Đặt biển quảng cáo hoặc mã QR tại trạm, đưa ra ưu đãi “thử membership 1 tháng với giá rẻ hơn”.
   * Tận dụng ứng dụng (push notification) ngay khi casual rider kết thúc một chuyến đi dài.

3. **Sử dụng digital media để tạo nhận thức và FOMO (Fear of Missing Out)**

   * Quảng cáo nhấn mạnh: “Annual Members tiết kiệm XX\$ mỗi năm so với casual riders”.
   * Tạo content trên mạng xã hội (video ngắn, infographic) minh họa sự khác biệt giữa chi phí casual vs. member.
   * Cá nhân hóa email marketing: gửi lời nhắc membership cho những rider đã mua >5 single rides trong tháng.

---




