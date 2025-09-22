# ---------------------------
# Load libraries
# ---------------------------
library(tidyverse)
library(lubridate)
library(janitor)

# ---------------------------
# 1. Đọc dữ liệu
# ---------------------------
q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv") %>% clean_names()
q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv") %>% clean_names()

# ---------------------------
# 2. Kiểm tra dữ liệu ban đầu
# ---------------------------
glimpse(q1_2019)
glimpse(q1_2020)

colSums(is.na(q1_2019))
colSums(is.na(q1_2020))

sum(duplicated(q1_2019))
sum(duplicated(q1_2020))

# ---------------------------
# 3. Chuẩn hóa schema
# ---------------------------
# Rename cột của q1_2019 cho giống q1_2020
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

# Chuẩn hóa member_casual
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
# 4. Đồng bộ kiểu dữ liệu
# ---------------------------
q1_2019 <- q1_2019 %>% mutate(ride_id = as.character(ride_id))
q1_2020 <- q1_2020 %>% mutate(ride_id = as.character(ride_id))

# ---------------------------
# 5. Gộp dữ liệu
# ---------------------------
all_trips <- bind_rows(q1_2019, q1_2020)

# ---------------------------
# 6. Tạo biến mới
# ---------------------------
all_trips <- all_trips %>%
  mutate(
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    day_of_week = wday(started_at, label = TRUE, abbr = FALSE),
    month = month(started_at, label = TRUE, abbr = TRUE),
    hour = hour(started_at)
  )

# ---------------------------
# 7. Làm sạch dữ liệu
# ---------------------------
all_trips_clean <- all_trips %>%
  filter(!is.na(start_station_name) & !is.na(end_station_name)) %>%
  filter(ride_length > 0 & ride_length < 1440) %>%   # loại bỏ chuyến bất hợp lý
  distinct()                                        # loại bỏ duplicate

# ---------------------------
# 8. Kiểm tra integrity sau cleaning
# ---------------------------
summary(all_trips_clean$ride_length)
table(all_trips_clean$member_casual)

# Thống kê ride_length (tính bằng phút)
mean(all_trips_clean$ride_length)   # trung bình
median(all_trips_clean$ride_length) # trung vị
max(all_trips_clean$ride_length)    # dài nhất
min(all_trips_clean$ride_length)    # ngắn nhất

# Trung bình thời gian đi xe theo loại người dùng
all_trips_clean %>%
  group_by(member_casual) %>%
  summarise(
    mean_ride_length = mean(ride_length),
    median_ride_length = median(ride_length),
    max_ride_length = max(ride_length),
    count_rides = n()
  )

# Thời gian trung bình đi xe theo loại user & ngày trong tuần
all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(
    avg_ride_length = mean(ride_length),
    count_rides = n(),
    .groups = "drop"
  )

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

library(scales)
install.packages("tidytext")
library(tidytext)


# đảm bảo day_of_week theo thứ tự từ Chủ nhật -> Thứ 7 (hoặc đặt theo Monday-first nếu bạn thích)
day_levels <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
all_trips_clean <- all_trips_clean %>%
  mutate(day_of_week = factor(day_of_week, levels = day_levels))

# 1) Bar: số chuyến theo ngày trong tuần
df_day <- all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(count = n(), .groups = "drop")

p1 <- ggplot(df_day, aes(x = day_of_week, y = count, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = comma) +
  scale_fill_viridis_d(option = "D", end = .8) +
  labs(title = "Số chuyến theo ngày trong tuần — Member vs Casual",
       subtitle = "So sánh tổng số chuyến trong Q1 2019 + Q1 2020",
       x = NULL, y = "Số chuyến", fill = "Loại người dùng") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# 2) Thời lượng trung bình theo ngày trong tuần (line)
df_len_day <- all_trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(avg_len = mean(ride_length), .groups = "drop")

p2 <- ggplot(df_len_day, aes(x = day_of_week, y = avg_len, color = member_casual, group = member_casual)) +
  geom_line(size = 1.2) + geom_point(size = 2) +
  labs(title = "Thời lượng trung bình chuyến đi theo ngày",
       y = "Thời lượng trung bình (phút)", x = NULL, color = "Loại người dùng") +
  scale_color_viridis_d(option="C") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# 3) Heatmap: giờ trong ngày x ngày trong tuần (facet theo member_casual)
df_heat <- all_trips_clean %>%
  group_by(member_casual, day_of_week, hour) %>%
  summarise(count = n(), .groups = "drop")

p3 <- ggplot(df_heat, aes(x = hour, y = day_of_week, fill = count)) +
  geom_tile() +
  facet_wrap(~member_casual) +
  scale_fill_viridis_c(trans = "sqrt", labels = comma) +
  labs(title = "Mật độ chuyến đi theo giờ và ngày (kép cho member vs casual)",
       x = "Giờ trong ngày", y = NULL, fill = "Số chuyến") +
  theme_minimal(base_size = 14)

# 4) Boxplot phân phối ride_length (cắt để dễ quan sát)
p4 <- all_trips_clean %>%
  filter(ride_length <= 120) %>%  # cắt >120 phút để focus distribution
  ggplot(aes(x = member_casual, y = ride_length, fill = member_casual)) +
  geom_boxplot(outlier.size = 0.8) +
  geom_jitter(width = 0.15, alpha = 0.05, size = 0.4) +
  labs(title = "Phân phối thời lượng chuyến đi (<= 120 phút)",
       x = NULL, y = "Thời lượng (phút)") +
  scale_fill_viridis_d(option="D") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

# 5) Top 10 start stations per group
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
  labs(title = "Top 10 Start Stations — phân theo Member / Casual",
       x = NULL, y = "Số chuyến") +
  theme_minimal(base_size = 13)

# Lưu ảnh chất lượng cao
ggsave("p1_day_counts.png", p1, width = 10, height = 6, dpi = 300)
ggsave("p2_avg_length_by_day.png", p2, width = 10, height = 6, dpi = 300)
ggsave("p3_heatmap_hour_day.png", p3, width = 12, height = 6, dpi = 300)
ggsave("p4_boxplot_length.png", p4, width = 8, height = 6, dpi = 300)
ggsave("p5_top_stations.png", p5, width = 12, height = 7, dpi = 300)


