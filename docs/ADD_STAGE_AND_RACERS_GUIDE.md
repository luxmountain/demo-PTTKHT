# Hướng dẫn sử dụng chức năng quản lý chặng đua

## Các chức năng đã thêm

### 1. Thêm chặng đua mới (Add New Stage)

**File liên quan:**
- `web/admin/addStage.jsp` - Trang form thêm chặng đua
- `web/admin/doAddStage.jsp` - Xử lý thêm chặng đua
- `src/java/dao/StageDAO.java` - Method `addStage()`

**Cách sử dụng:**
1. Đăng nhập với tài khoản admin
2. Vào trang "Stage List" (danh sách chặng đua)
3. Click nút **"+ Add New Stage"**
4. Điền thông tin:
   - **Stage Name** (*): Tên chặng đua
   - **Date** (*): Ngày tổ chức
   - **Location** (*): Địa điểm
   - **Description**: Mô tả (tùy chọn)
   - **Roadmap**: Lộ trình (tùy chọn)
   - **Total Laps** (*): Số vòng đua
   - **Season** (*): Chọn mùa giải
5. Click "Add Stage" để lưu

**Lưu ý:**
- Các trường có dấu (*) là bắt buộc
- Số vòng đua phải lớn hơn 0
- Chặng đua mới sẽ có trạng thái "Active" mặc định

### 2. Thêm tay đua vào chặng đua (Add Racers to Stage)

**File liên quan:**
- `web/admin/addRacerToStage.jsp` - Trang chọn và thêm tay đua
- `web/admin/doAddRacerToStage.jsp` - Xử lý thêm tay đua
- `src/java/dao/RegisterDAO.java` - Methods:
  - `getAvailableRacers()` - Lấy danh sách tay đua có thể thêm
  - `addRegister()` - Thêm tay đua vào chặng đua

**Cách sử dụng:**
1. Từ trang "Stage List", tìm chặng đua cần thêm tay đua
2. Click nút **"Add Racers"** ở cột Options
3. Trang sẽ hiển thị:
   - **Currently Registered Racers**: Tay đua đã đăng ký
   - **Available Racers**: Tay đua có thể thêm vào
4. Chọn các tay đua muốn thêm (có thể dùng "Select All")
5. Click "Add Selected Racers" để xác nhận

**Lưu ý:**
- Chỉ hiển thị tay đua có hợp đồng đang hoạt động
- Tay đua đã đăng ký cho chặng đua sẽ không hiển thị trong danh sách
- Danh sách được sắp xếp theo đội và tên tay đua

### 3. Cập nhật kết quả chặng đua (Update Results)

**Luồng công việc hoàn chỉnh:**
1. **Tạo chặng đua mới** → Click "Add New Stage"
2. **Thêm tay đua** → Click "Add Racers" cho chặng vừa tạo
3. **Cập nhật kết quả** → Click "Update Results" sau khi chặng đua diễn ra

## Cấu trúc Database

### Bảng tblstage (Chặng đua)
```sql
CREATE TABLE `tblstage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255),
  `date` date,
  `location` varchar(255),
  `description` varchar(255),
  `roadmap` varchar(255),
  `total_laps` smallint UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(1),
  `tblSeasonid` int,
  PRIMARY KEY (`id`)
)
```

### Bảng tblregister (Đăng ký tay đua vào chặng)
```sql
CREATE TABLE `tblregister` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateregistered` date,
  `status` tinyint(1),
  `laps_completed` smallint UNSIGNED,
  `timedone` time(6),
  `tblContractid` int,
  `tblStageid` int,
  PRIMARY KEY (`id`)
)
```

## Model Classes đã cập nhật

### Register.java
Đã thêm:
- `private int contractId`
- `private int stageId`
- `getContractId()` / `setContractId()`
- `getStageId()` / `setStageId()`

## API Methods

### StageDAO
```java
// Thêm chặng đua mới
public boolean addStage(Stage stage)
```

### RegisterDAO
```java
// Lấy danh sách tay đua có thể thêm vào chặng
public List<Map<String, Object>> getAvailableRacers(int stageId)

// Thêm tay đua vào chặng đua
public boolean addRegister(Register register)
```

## Ví dụ sử dụng

### Tạo chặng đua "Ha Noi Final 2025"
1. Add New Stage:
   - Name: Ha Noi Final 2025
   - Date: 2025-03-15
   - Location: Ha Noi
   - Total Laps: 10
   - Season: Hoa Sen (2024)

2. Add Racers:
   - Chọn các tay đua từ danh sách available
   - Submit để đăng ký

3. Update Results (sau khi đua):
   - Nhập số vòng hoàn thành và thời gian cho từng tay đua
   - Lưu kết quả

## Lỗi thường gặp và cách khắc phục

1. **"No available racers to add"**
   - Nguyên nhân: Tất cả tay đua đã được đăng ký hoặc không có hợp đồng active
   - Giải pháp: Kiểm tra trạng thái hợp đồng trong database

2. **"Failed to add stage"**
   - Nguyên nhân: Thiếu thông tin bắt buộc hoặc lỗi database
   - Giải pháp: Kiểm tra log trong console và đảm bảo tất cả trường bắt buộc đã điền

3. **"No racers registered for this stage"** (trang Update Results)
   - Nguyên nhân: Chưa thêm tay đua vào chặng đua
   - Giải pháp: Click "Add Racers" để thêm tay đua trước khi cập nhật kết quả
