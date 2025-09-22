# Cyclistic-Bike-Share-Case-Study
Google Data Analytics Case Study

---

## 📌 Tóm tắt bối cảnh Case Study: *Cyclistic Bike-Share*

### 1. Công ty Cyclistic

* **Dịch vụ:** Hệ thống thuê xe đạp ở Chicago.
* **Quy mô:**

  * 5,800+ xe đạp.
  * 600+ trạm docking.
* **Đặc điểm nổi bật:** Ngoài xe đạp thường, Cyclistic còn có xe đặc biệt (reclining bikes, hand tricycles, cargo bikes) → phục vụ cả người khuyết tật.
* **Mục đích sử dụng:**

  * Chủ yếu là giải trí.
  * \~30% dùng để đi làm hàng ngày.

---

### 2. Các loại khách hàng

* **Casual riders (khách vãng lai):** mua vé lẻ hoặc vé 1 ngày.
* **Members (thành viên thường niên):** mua gói 1 năm → **có lợi nhuận cao hơn** cho công ty.

---

### 3. Vấn đề & mục tiêu

* **Vấn đề:** Hiện tại Cyclistic tập trung marketing đại trà, chưa có chiến lược chuyển đổi casual riders thành annual members.
* **Mục tiêu:**

  * Hiểu **sự khác biệt trong hành vi sử dụng** giữa casual riders và members.
  * Xác định lý do tại sao casual riders có thể muốn nâng cấp lên membership.
  * Đề xuất chiến lược marketing (email, social media, digital marketing) để **chuyển đổi casual → member**.

---

### 4. Nhân vật & đội ngũ

* **Bạn:** Junior Data Analyst trong team marketing analytics.
* **Lily Moreno:** Giám đốc marketing, trực tiếp quản lý bạn.
* **Marketing analytics team:** Thu thập, phân tích, báo cáo dữ liệu.
* **Executive team:** Hội đồng quản trị → phê duyệt chiến lược (cần báo cáo dữ liệu thuyết phục, visualization rõ ràng).

---

### 5. Yêu cầu phân tích

* Dựa trên **dữ liệu lịch sử các chuyến đi** (bike trip data).
* So sánh casual riders vs annual members theo:

  * Thời gian đi xe (ngày trong tuần, mùa, giờ cao điểm).
  * Mục đích sử dụng (giải trí vs đi làm).
  * Tần suất và thói quen đi xe.

---

👉 **Tóm gọn:**
Công ty Cyclistic muốn phân tích sự khác biệt hành vi giữa khách vãng lai và khách thành viên, từ đó thiết kế chiến lược marketing thuyết phục khách vãng lai trở thành thành viên thường niên, vì nhóm này mang lại lợi nhuận cao hơn.

---
---

## 📌 Business Task (Nhiệm vụ phân tích)

**Vấn đề cần giải quyết:**
Cyclistic muốn tăng số lượng **annual members** vì nhóm này mang lại lợi nhuận cao hơn so với **casual riders**. Để thiết kế một chiến lược marketing hiệu quả, cần hiểu rõ **sự khác biệt trong hành vi sử dụng xe** giữa hai nhóm khách hàng.

**Câu hỏi trọng tâm :**
👉 *How do annual members and casual riders use Cyclistic bikes differently?*
(Thành viên thường niên và khách vãng lai sử dụng xe đạp của Cyclistic khác nhau như thế nào?)

**Mục tiêu phân tích:**

* So sánh hành vi sử dụng giữa **casual riders** và **annual members**.
* Xác định các **pattern**: thời gian đi (giờ/ngày trong tuần/tháng), độ dài chuyến đi, mục đích sử dụng.
* Rút ra insight giúp marketing team **xây dựng chiến lược chuyển đổi casual → member**.

**Stakeholders (người liên quan):**

* **Lily Moreno (Marketing Director):** trực tiếp sử dụng kết quả phân tích để lên chiến dịch marketing.
* **Marketing Analytics Team:** hỗ trợ phân tích dữ liệu.
* **Executive Team:** quyết định có chấp thuận chiến lược marketing hay không.

---

👉 **Deliverable:**

> *The business task is to analyze and compare the riding behaviors of casual riders and annual members of Cyclistic in order to identify key differences. These insights will support the marketing strategy aimed at converting casual riders into annual members.*

---
---

## 📌 Prepare – Cyclistic Bike-Share Case Study

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

### 3. Độ tin cậy dữ liệu (ROCCC Framework)

* **Reliable (Đáng tin cậy):** Dữ liệu từ Motivate International Inc. → nguồn chính thức, uy tín.
* **Original (Nguyên bản):** Dữ liệu gốc từ hệ thống bike-share.
* **Comprehensive (Đầy đủ):** Bao gồm các biến quan trọng để phân tích hành vi (thời gian, địa điểm, loại khách hàng).
* **Current (Cập nhật):** Dữ liệu là lịch sử (2019–2020), đủ để phân tích xu hướng theo mùa và theo loại khách.
* **Cited (Có trích dẫn):** Dữ liệu được cấp phép sử dụng công khai.

---

### 4. Các vấn đề cần lưu ý

* **Bảo mật & quyền riêng tư:** Không chứa thông tin cá nhân nhạy cảm (chỉ dữ liệu hành vi).
* **Data quality issues:**

  * Có thể có **giá trị thiếu** (station name trống).
  * Có thể có **outliers** (ride time âm, hoặc chuyến đi quá dài bất thường).
  * Format thời gian có thể khác giữa hai bộ dữ liệu (2019 vs 2020).

---

### 5. Ý nghĩa đối với phân tích

* Dataset chứa thông tin phân loại **casual riders vs members** → trực tiếp hỗ trợ câu hỏi chính: *“How do annual members and casual riders use Cyclistic bikes differently?”*
* Có thể tính toán:

  * **Độ dài chuyến đi** (trip duration).
  * **Ngày trong tuần** hoặc **giờ trong ngày** để tìm pattern sử dụng.
  * **Số lượng chuyến đi** theo loại khách hàng.

---

👉 **Deliverable:**

> The data used for this analysis comes from Motivate International Inc., which operates the Divvy bike-share system in Chicago. Specifically, I will use the Divvy Q1 2019 and Divvy Q1 2020 datasets. These datasets are organized in CSV format, with each row representing a single bike trip and columns providing details such as trip start and end times, station locations, and rider type (casual vs. member). The data is publicly available under an appropriate license, free of personally identifiable information, and verified as reliable and comprehensive for analyzing differences between casual riders and annual members.

---

---

## 📌 Process – Cyclistic Bike-Share Case Study

### 1. Công cụ sử dụng

* **RStudio** với các thư viện chính:

  * `tidyverse` (xử lý dữ liệu & visualization cơ bản).
  * `lubridate` (xử lý ngày giờ).
  * `janitor` (dọn tên cột).
* Lý do chọn RStudio: Hỗ trợ thao tác dữ liệu lớn, dễ lập trình pipeline và trực quan hóa.

---

### 2. Các bước xử lý dữ liệu

#### 🔹 Bước 1: Import dữ liệu

```R
library(tidyverse)
library(lubridate)
library(janitor)

# đọc dữ liệu
q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv") %>% clean_names()
q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv") %>% clean_names()
```

---

#### 🔹 Bước 2: Kiểm tra dữ liệu

* Kiểm tra số dòng, số cột, và các biến:

```R
glimpse(q1_2019)
glimpse(q1_2020)
```

* Tìm giá trị thiếu (`NA`) và dữ liệu ngoại lai:

```R
colSums(is.na(q1_2019))
colSums(is.na(q1_2020))
```

---

#### 🔹 Bước 3: Chuẩn hóa dữ liệu

* Đảm bảo hai bộ dữ liệu có cùng format (2019 và 2020 có thể đặt tên cột khác).
* Đổi tên cột cho đồng nhất (`start_time`, `end_time`, `member_casual` …).

Ví dụ:

```R
q1_2019 <- q1_2019 %>% 
  rename(started_at = start_time, ended_at = end_time, member_casual = usertype)

q1_2020 <- q1_2020 %>% 
  rename(started_at = start_time, ended_at = end_time, member_casual = usertype)
```

---

#### 🔹 Bước 4: Tạo biến mới

* **Ride length (thời lượng chuyến đi):**

```R
q1_2019 <- q1_2019 %>% 
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")))

q1_2020 <- q1_2020 %>% 
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")))
```

* **Day of week (ngày trong tuần):**

```R
q1_2019 <- q1_2019 %>% 
  mutate(day_of_week = wday(started_at, label = TRUE))

q1_2020 <- q1_2020 %>% 
  mutate(day_of_week = wday(started_at, label = TRUE))
```

---

#### 🔹 Bước 5: Loại bỏ dữ liệu không hợp lệ

* **Loại chuyến đi có thời gian âm hoặc bằng 0.**

```R
q1_2019 <- q1_2019 %>% filter(ride_length > 0)
q1_2020 <- q1_2020 %>% filter(ride_length > 0)
```

* **Loại outliers bất thường** (ví dụ: chuyến đi > 24 giờ).

```R
q1_2019 <- q1_2019 %>% filter(ride_length < 1440)
q1_2020 <- q1_2020 %>% filter(ride_length < 1440)
```

---

#### 🔹 Bước 6: Kết hợp dữ liệu

```R
all_trips <- bind_rows(q1_2019, q1_2020)
```

---

### 3. Đảm bảo tính toàn vẹn dữ liệu

* Kiểm tra lại số dòng sau khi loại bỏ outliers.
* Đảm bảo biến `member_casual` chỉ chứa 2 giá trị (“member”, “casual”).

```R
table(all_trips$member_casual)
```

---

### 4. Deliverable 

> The data was imported into RStudio and cleaned to ensure integrity and consistency. Column names were standardized, missing values and anomalies were checked, and new calculated fields (`ride_length`, `day_of_week`) were added. Invalid trips with negative or zero durations, as well as outliers exceeding 24 hours, were removed. Finally, the datasets from Q1 2019 and Q1 2020 were merged into a single dataset for further analysis.

---

---

## 🎯 Mục tiêu trong bước Analyze

* Tổng hợp dữ liệu (aggregate).
* Làm thống kê mô tả (descriptive analysis).
* Tìm trends và quan hệ giữa **casual** và **member**.
* Chuẩn bị insight để trả lời câu hỏi:
  👉 *How do annual members and casual riders use Cyclistic bikes differently?*

---

## 🔎 1. Descriptive statistics cơ bản

Ví dụ với dataset `all_trips_clean`:

```r
# Thống kê ride_length (tính bằng phút)
mean(all_trips_clean$ride_length)   # trung bình
median(all_trips_clean$ride_length) # trung vị
max(all_trips_clean$ride_length)    # dài nhất
min(all_trips_clean$ride_length)    # ngắn nhất
```

---

## 🔎 2. Tổng hợp theo loại người dùng

```r
# Trung bình thời gian đi xe theo loại người dùng
all_trips_clean %>%
  group_by(member_casual) %>%
  summarise(
    mean_ride_length = mean(ride_length),
    median_ride_length = median(ride_length),
    max_ride_length = max(ride_length),
    count_rides = n()
  )
```

---

## 🔎 3. Phân tích theo ngày trong tuần

```r
# Thời gian trung bình đi xe theo loại user & ngày trong tuần
all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(
    avg_ride_length = mean(ride_length),
    count_rides = n(),
    .groups = "drop"
  )
```

---

## 🔎 4. Visualization (sử dụng ggplot2)


```r
library(ggplot2)

# Số chuyến đi theo ngày trong tuần
all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(count_rides = n(), .groups = "drop") %>%
  ggplot(aes(x = day_of_week, y = count_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Số chuyến đi theo ngày trong tuần",
       x = "Ngày trong tuần", y = "Số chuyến đi")

# Thời gian trung bình theo ngày trong tuần
all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(avg_ride_length = mean(ride_length), .groups = "drop") %>%
  ggplot(aes(x = day_of_week, y = avg_ride_length, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Thời gian đi xe trung bình theo ngày trong tuần",
       x = "Ngày trong tuần", y = "Thời gian (phút)")
```

---

## 🔎 5. Phân tích theo tháng hoặc giờ

```r
# Theo tháng
all_trips_clean %>%
  group_by(member_casual, month) %>%
  summarise(count_rides = n(), avg_length = mean(ride_length), .groups = "drop")

# Theo giờ
all_trips_clean %>%
  group_by(member_casual, hour) %>%
  summarise(count_rides = n(), avg_length = mean(ride_length), .groups = "drop")
```

---

## 📊 Deliverable của Analyze

 **Summary of Analysis**:

1. Casual riders có xu hướng đi lâu hơn nhưng ít thường xuyên.
2. Members đi nhiều chuyến hơn, đặc biệt vào ngày thường (commuting).
3. Casual riders thích cuối tuần, có xu hướng dùng cho giải trí.

---
Tuyệt — dưới vai trò mentor mình sẽ cho bạn một **khuôn mẫu hoàn chỉnh** để thực hiện bước **Share**: gồm loại biểu đồ nên dùng, luận điểm cho từng biểu đồ, mã R (ggplot2) chuẩn để bạn chạy trực tiếp trên `all_trips_clean`, cách xuất ảnh chất lượng cao, và checklist để trình bày chuyên nghiệp + tiếp cận cho ban điều hành. Mình giữ giọng khách quan, tập trung vào tính thực tế và khả năng thuyết phục.

# 1) Các visual nên tạo (và vì sao)

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

## 📌 3 khuyến nghị chính (deliverable)

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




