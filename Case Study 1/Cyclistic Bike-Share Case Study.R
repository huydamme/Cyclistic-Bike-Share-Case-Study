# ---------------------------
# Load libraries
# ---------------------------
library(tidyverse)
library(lubridate)
library(janitor)
library(ggplot2)
library(scales)
install.packages("viridis")   # cài package
library(viridis)              # load package
library(tidytext)   # dùng cho reorder_within()

# ---------------------------
# 1. Đọc dữ liệu
# ---------------------------
q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv") %>% clean_names()
q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv") %>% clean_names()

# ---------------------------
# 2. Kiểm tra dữ liệu ban đầu
# ---------------------------
glimpse(q1_2019)    # cấu trúc dữ liệu Q1 2019
glimpse(q1_2020)    # cấu trúc dữ liệu Q1 2020

colSums(is.na(q1_2019)) # kiểm tra giá trị thiếu
colSums(is.na(q1_2020))

sum(duplicated(q1_2019)) # kiểm tra trùng lặp
sum(duplicated(q1_2020))

# ---------------------------
# 3. Chuẩn hóa schema (đặt tên cột giống nhau)
# ---------------------------
q1_2019 <- q1_2019 %>%
  rename(
    ride_id = trip_id,
    started_at = start_time,
    ended_at = end_time,
    start_station_name = from_station_name,
    end_station_name = to_station_name,
    start_station_id = from_station_id,
    end_station_id = to_station_id,
    member_casual = usertype
  )

# ---------------------------
# 4. Chuẩn hóa giá trị member_casual
# ---------------------------
q1_2019 <- q1_2019 %>%
  mutate(member_casual = case_when(
    member_casual == "Subscriber" ~ "member",
    member_casual == "Customer" ~ "casual",
    TRUE ~ member_casual
  ))

q1_2020 <- q1_2020 %>%
  mutate(member_casual = case_when(
    member_casual %in% c("member", "Subscriber") ~ "member",
    member_casual %in% c("casual", "Customer") ~ "casual",
    TRUE ~ member_casual
  ))

# ---------------------------
# 5. Đồng bộ kiểu dữ liệu (ride_id về character)
# ---------------------------
q1_2019 <- q1_2019 %>% mutate(ride_id = as.character(ride_id))
q1_2020 <- q1_2020 %>% mutate(ride_id = as.character(ride_id))

# ---------------------------
# 6. Gộp dữ liệu
# ---------------------------
all_trips <- bind_rows(q1_2019, q1_2020)

# ---------------------------
# 7. Tạo biến mới để phân tích
# ---------------------------
all_trips <- all_trips %>%
  mutate(
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    day_of_week = wday(started_at, label = TRUE, abbr = FALSE), # thứ trong tuần
    month = month(started_at, label = TRUE, abbr = TRUE),       # tháng
    hour = hour(started_at)                                     # giờ
  )

# ---------------------------
# 8. Làm sạch dữ liệu
# ---------------------------
all_trips_clean <- all_trips %>%
  filter(!is.na(start_station_name) & !is.na(end_station_name)) %>%
  filter(ride_length > 0 & ride_length < 1440) %>%  # loại bỏ bất hợp lý (>24h)
  distinct()                                       # loại bỏ duplicate

# ---------------------------
# 9. Kiểm tra integrity sau cleaning
# ---------------------------
summary(all_trips_clean$ride_length)
table(all_trips_clean$member_casual)

# ---------------------------
# 10. Visualization
# ---------------------------

# (1) Bar chart: số chuyến theo ngày trong tuần
df_day <- all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(count = n(), .groups = "drop")

p1 <- ggplot(df_day, aes(x = day_of_week, y = count, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = comma) +
  scale_fill_viridis_d(option = "D", end = .8) +
  labs(title = "Số chuyến theo ngày trong tuần — Member vs Casual",
       subtitle = "So sánh Q1 2019 + Q1 2020",
       x = NULL, y = "Số chuyến", fill = "Loại người dùng") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# (2) Line chart: thời lượng trung bình theo ngày
df_len_day <- all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(avg_len = mean(ride_length), .groups = "drop")

p2 <- ggplot(df_len_day, aes(x = day_of_week, y = avg_len, color = member_casual, group = member_casual)) +
  geom_line(size = 1.2) + geom_point(size = 2) +
  labs(title = "Thời lượng trung bình chuyến đi theo ngày",
       y = "Phút", x = NULL, color = "Loại người dùng") +
  scale_color_viridis_d(option="C") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# (3) Heatmap: mật độ chuyến đi theo giờ × ngày
df_heat <- all_trips_clean %>%
  group_by(member_casual, day_of_week, hour) %>%
  summarise(count = n(), .groups = "drop")

p3 <- ggplot(df_heat, aes(x = hour, y = day_of_week, fill = count)) +
  geom_tile() +
  facet_wrap(~member_casual) +
  scale_fill_viridis_c(trans = "sqrt", labels = comma) +
  labs(title = "Mật độ chuyến đi theo giờ và ngày",
       x = "Giờ trong ngày", y = NULL, fill = "Số chuyến") +
  theme_minimal(base_size = 14)

# (4) Boxplot: phân phối thời lượng (<=120 phút, optional)
p4 <- all_trips_clean %>%
  filter(ride_length <= 120) %>%
  ggplot(aes(x = member_casual, y = ride_length, fill = member_casual)) +
  geom_boxplot(outlier.size = 0.8) +
  labs(title = "Phân phối thời lượng chuyến đi (<=120 phút)",
       x = NULL, y = "Phút") +
  scale_fill_viridis_d(option="D") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

# (5) Top 10 start stations theo nhóm
top_stations <- all_trips_clean %>%
  group_by(member_casual, start_station_name) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(member_casual) %>%
  slice_max(order_by = count, n = 10) %>%
  ungroup()

p5 <- ggplot(top_stations, aes(x = reorder_within(start_station_name, count, member_casual), 
                               y = count, fill = member_casual)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~member_casual, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  scale_fill_viridis_d(option = "D") +
  labs(title = "Top 10 trạm khởi hành — Member vs Casual",
       x = NULL, y = "Số chuyến") +
  theme_minimal(base_size = 13)

# ---------------------------
# 11. Xuất ảnh chất lượng cao
# ---------------------------
ggsave("p1_day_counts.png", p1, width = 10, height = 6, dpi = 300)
ggsave("p2_avg_length_by_day.png", p2, width = 10, height = 6, dpi = 300)
ggsave("p3_heatmap_hour_day.png", p3, width = 12, height = 6, dpi = 300)
ggsave("p5_top_stations.png", p5, width = 12, height = 7, dpi = 300)
# (p4 có thể bỏ nếu không cần)
