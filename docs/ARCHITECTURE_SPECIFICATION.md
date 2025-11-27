# Đặc tả kiến trúc hệ thống quản lý giải đua xe đạp

## 1. Tầng giao diện (JSP Pages)

### 1.0 Giao diện chung (Common Pages)

#### index.jsp
- **Mục đích**: Trang điều hướng ban đầu (router) của hệ thống
- **Chức năng**: 
  - Kiểm tra session để xác định vai trò người dùng (admin/user)
  - Điều hướng admin → `admin/adminHome.jsp`
  - Điều hướng user → `user/userHome.jsp`
  - Điều hướng chưa đăng nhập → `login.jsp`
- **Logic**: Không có giao diện hiển thị, chỉ chứa logic redirect

#### login.jsp
- **Mục đích**: Giao diện đăng nhập vào hệ thống
- **Chức năng**:
  - Hiển thị form nhập username và password
  - Hiển thị thông báo lỗi nếu có (timeout, failed login)
  - Submit đến `doLogin.jsp` để xử lý đăng nhập
- **Parameters nhận vào**:
  - `error` (optional): timeout | failed - Loại lỗi cần hiển thị
- **Form fields**: username, password

#### doLogin.jsp
- **Mục đích**: Xử lý logic đăng nhập
- **Chức năng**:
  - Nhận username và password từ form
  - Gọi `MemberDAO.checkLogin()` để xác thực
  - Tạo session mới và lưu thông tin member
  - Phân quyền: ADMIN → `admin/adminHome.jsp`, USER → `user/userHome.jsp`
  - Redirect về `login.jsp?error=failed` nếu đăng nhập thất bại
- **Parameters nhận vào**: username, password
- **Session attributes set**: 
  - `admin` (Member) - nếu là admin
  - `user` (Member) - nếu là user

### 1.1 Giao diện dành cho Ban tổ chức (Admin)

#### adminHome.jsp
- **Mục đích**: Giao diện chính dành cho thành viên ban tổ chức
- **Chức năng**: 
  - Hiển thị menu điều hướng đến các chức năng quản lý
  - Truy cập quản lý chặng đua, cập nhật kết quả

#### stageList.jsp
- **Mục đích**: Hiển thị danh sách các chặng đua
- **Chức năng**:
  - Liệt kê tất cả các chặng đua trong hệ thống
  - Cung cấp link để cập nhật kết quả từng chặng

#### updateResult.jsp
- **Mục đích**: Giao diện cập nhật kết quả cho một chặng đua
- **Chức năng**:
  - Hiển thị form nhập số vòng đua hoàn thành và thời gian hoàn thành
  - Submit dữ liệu để cập nhật kết quả

#### doUpdateResult.jsp
- **Mục đích**: Xử lý logic cập nhật kết quả
- **Chức năng**:
  - Nhận dữ liệu từ form updateResult.jsp
  - Gọi ResultDAO để lưu kết quả
  - Tự động tính toán và cập nhật thống kê team

### 1.2 Giao diện dành cho Người dùng (User)

#### userHome.jsp
- **Mục đích**: Giao diện chính dành cho người dùng xem thông tin
- **Chức năng**:
  - Hiển thị menu điều hướng
  - Truy cập các chức năng xem bảng xếp hạng, tìm kiếm

#### chooseTypeRanking.jsp
- **Mục đích**: Giao diện để chọn kiểu xem bảng xếp hạng
- **Chức năng**:
  - Cho phép chọn xem theo Mùa giải hoặc theo Chặng đua
  - Điều hướng đến trang tương ứng

#### chooseSeason.jsp
- **Mục đích**: Giao diện để chọn mùa giải muốn xem bảng xếp hạng
- **Chức năng**:
  - Hiển thị danh sách các mùa giải
  - Điều hướng đến teamRanking.jsp với seasonId

#### chooseRace.jsp
- **Mục đích**: Giao diện để chọn chặng đua muốn xem bảng xếp hạng
- **Chức năng**:
  - Hiển thị danh sách các chặng đua theo mùa giải
  - Điều hướng đến teamRanking.jsp với stageId

#### teamRanking.jsp
- **Mục đích**: Giao diện để người dùng xem bảng xếp hạng đội đua
- **Chức năng**:
  - Hiển thị bảng xếp hạng các đội theo mùa giải hoặc chặng đua đã chọn
  - Hiển thị thông tin: Rank, Team Name, Points, Wins, Status
  - Cung cấp link xem chi tiết từng đội

#### teamDetail.jsp
- **Mục đích**: Giao diện hiển thị thông tin chi tiết của đội đua
- **Chức năng**:
  - Hiển thị thông tin tổng quan: tên đội, quốc gia, mô tả
  - Hiển thị danh sách các tay đua trong đội
  - Hiển thị thành tích theo từng chặng
  - Cung cấp link xem chi tiết từng tay đua

#### racerDetail.jsp
- **Mục đích**: Giao diện hiển thị thông tin chi tiết của tay đua
- **Chức năng**:
  - Hiển thị thông tin cá nhân: tên, quốc tịch, số áo
  - Hiển thị lịch sử thi đấu theo các chặng
  - Hiển thị thống kê: tổng điểm, số podium, best position

#### searchStage.jsp
- **Mục đích**: Giao diện tìm kiếm chặng đua
- **Chức năng**:
  - Cung cấp form nhập từ khóa tìm kiếm
  - Submit đến doSearchStage.jsp

#### doSearchStage.jsp
- **Mục đích**: Xử lý logic tìm kiếm chặng đua
- **Chức năng**:
  - Nhận keyword từ form
  - Gọi StageDAO.searchStage()
  - Lưu kết quả vào session và điều hướng

#### stageListSearch.jsp
- **Mục đích**: Hiển thị kết quả tìm kiếm chặng đua
- **Chức năng**:
  - Lấy danh sách từ session
  - Hiển thị các chặng tìm được
  - Cung cấp link xem chi tiết

#### stageDetail.jsp
- **Mục đích**: Giao diện hiển thị thông tin chi tiết của chặng đua
- **Chức năng**:
  - Hiển thị thông tin: tên, địa điểm, ngày thi đấu, mô tả
  - Hiển thị kết quả tay đua trong chặng
  - Hiển thị bảng xếp hạng team trong chặng

---

## 2. Tầng thao tác với dữ liệu (DAO Layer)

### 2.1 DAO (Base Class)
- **Mục đích**: Lớp cơ sở để kết nối với cơ sở dữ liệu
- **Chức năng**: 
  - Cung cấp kết nối (Connection) cho tất cả các lớp kế thừa
  - Quản lý connection pool

### 2.2 SeasonDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đối tượng Season**

#### Phương thức getAllSeasons()
- **Tham số truyền vào**: Không có
- **Giá trị trả về**: `List<Season>` - Danh sách các mùa giải trong hệ thống
- **Chức năng**: Lấy ra danh sách tất cả các mùa giải trong hệ thống

#### Phương thức getSeasonById(int seasonId)
- **Tham số truyền vào**: 
  - `seasonId` - ID của mùa giải
- **Giá trị trả về**: `Season` - Đối tượng mùa giải
- **Chức năng**: Lấy thông tin chi tiết của một mùa giải theo ID

### 2.3 StageDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đối tượng Stage**

#### Phương thức getAllStages()
- **Tham số truyền vào**: Không có
- **Giá trị trả về**: `List<Stage>` - Danh sách tất cả các chặng đua
- **Chức năng**: Lấy ra danh sách tất cả các chặng đua trong hệ thống

#### Phương thức getStagesBySeason(int seasonId)
- **Tham số truyền vào**: 
  - `seasonId` - ID của mùa giải mà ta muốn chọn
- **Giá trị trả về**: `List<Stage>` - Danh sách các chặng đua trong mùa giải đó
- **Chức năng**: Lấy ra danh sách các chặng đua thuộc mùa giải được chọn

#### Phương thức searchStage(String keyword)
- **Tham số truyền vào**: 
  - `keyword` - Từ khóa tìm kiếm
- **Giá trị trả về**: `List<Stage>` - Danh sách các chặng đua phù hợp
- **Chức năng**: Tìm kiếm chặng đua theo tên, địa điểm hoặc mô tả

#### Phương thức getStageInfo(int stageId)
- **Tham số truyền vào**: 
  - `stageId` - ID của chặng đua
- **Giá trị trả về**: `Stage` - Đối tượng chặng đua
- **Chức năng**: Lấy thông tin chi tiết của một chặng đua

### 2.4 TeamDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đối tượng Team**

#### Phương thức getTeamById(int teamId)
- **Tham số truyền vào**: 
  - `teamId` - ID của đội đua
- **Giá trị trả về**: `Team` - Đối tượng đội đua
- **Chức năng**: Lấy thông tin cơ bản của đội đua

#### Phương thức getTeamRankingsBySeason(int seasonId)
- **Tham số truyền vào**: 
  - `seasonId` - ID của mùa giải ta muốn xem bảng xếp hạng
- **Giá trị trả về**: `List<Map<String, Object>>` - Danh sách các đội đua với thông tin xếp hạng
- **Chức năng**: 
  - Lấy thông tin các đội đua trong mùa giải
  - Sắp xếp theo tổng điểm giảm dần (từ cao đến thấp)
  - Tính toán rank dựa trên totalpoints
  - Mỗi Map chứa: rank, teamId, teamName, nation, stagesParticipated, totalPoints, wins, status

#### Phương thức getTeamRankingsByStage(int stageId)
- **Tham số truyền vào**: 
  - `stageId` - ID của chặng đua ta muốn xem bảng xếp hạng
- **Giá trị trả về**: `List<Map<String, Object>>` - Danh sách các đội đua với thông tin xếp hạng trong chặng
- **Chức năng**: 
  - Lấy thông tin các đội đua trong chặng đua
  - Sắp xếp theo điểm trong chặng giảm dần
  - Tính toán rank dựa trên totalpoints
  - Mỗi Map chứa: rank, teamId, teamName, nation, racersParticipated, bestPosition, totalPoints, status

#### Phương thức getTeamSeasonStats(int teamId, int seasonId)
- **Tham số truyền vào**: 
  - `teamId` - ID của đội đua
  - `seasonId` - ID của mùa giải
- **Giá trị trả về**: `Map<String, Object>` - Thống kê của đội trong mùa giải
- **Chức năng**: 
  - Lấy tổng điểm của đội trong mùa giải
  - Tính rank của đội (bằng cách đếm số đội có điểm cao hơn)
  - Map chứa: totalPoints, rank

#### Phương thức getRacersByTeam(int teamId, int seasonId)
- **Tham số truyền vào**: 
  - `teamId` - ID của đội đua
  - `seasonId` - ID của mùa giải
- **Giá trị trả về**: `List<Map<String, Object>>` - Danh sách tay đua trong đội
- **Chức năng**: Lấy danh sách các tay đua thuộc đội trong mùa giải

#### Phương thức getTeamPerformanceByStage(int teamId, int seasonId)
- **Tham số truyền vào**: 
  - `teamId` - ID của đội đua
  - `seasonId` - ID của mùa giải
- **Giá trị trả về**: `List<Map<String, Object>>` - Danh sách thành tích theo từng chặng
- **Chức năng**: Lấy thành tích của đội qua các chặng trong mùa giải

#### Phương thức getTeamRacersInStage(int teamId, int stageId)
- **Tham số truyền vào**: 
  - `teamId` - ID của đội đua
  - `stageId` - ID của chặng đua
- **Giá trị trả về**: `List<Map<String, Object>>` - Danh sách tay đua và kết quả trong chặng
- **Chức năng**: Lấy danh sách tay đua của đội và kết quả của họ trong một chặng cụ thể

### 2.5 RacerDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đối tượng Racer**

#### Phương thức getRacerDetails(int racerId)
- **Tham số truyền vào**: 
  - `racerId` (int) - ID của tay đua (member ID)
- **Giá trị trả về**: `Map<String, Object>` - Thông tin cơ bản của tay đua
- **Chức năng**: 
  - Lấy thông tin cá nhân: racerId, racerName, dob, nationality, shirtNumber
  - JOIN giữa tblmember và tblracer

#### Phương thức getRacerTeamInSeason(int racerId, int seasonId)
- **Tham số truyền vào**: 
  - `racerId` (int) - ID của tay đua
  - `seasonId` (int) - ID của mùa giải
- **Giá trị trả về**: `String` - Tên đội của tay đua trong mùa giải
- **Chức năng**: Lấy tên đội mà tay đua thi đấu trong mùa giải cụ thể

#### Phương thức getRacerPerformanceByStage(int racerId, int seasonId)
- **Tham số truyền vào**: 
  - `racerId` (int) - ID của tay đua
  - `seasonId` (int) - ID của mùa giải
- **Giá trị trả về**: `List<Map<String, Object>>` - Lịch sử thi đấu của tay đua
- **Chức năng**: 
  - Lấy danh sách kết quả thi đấu theo từng chặng trong mùa giải
  - Mỗi Map chứa: stageName, stageDate, position, timeDone, points
  - Sắp xếp theo ngày thi đấu

#### Phương thức getRacerSeasonStats(int racerId, int seasonId)
- **Tham số truyền vào**: 
  - `racerId` (int) - ID của tay đua
  - `seasonId` (int) - ID của mùa giải
- **Giá trị trả về**: `Map<String, Object>` - Thống kê của tay đua trong mùa giải
- **Chức năng**: 
  - Tính tổng số chặng tham gia (stagesParticipated)
  - Tính tổng điểm (totalPoints)
  - Tính rank (sử dụng RANK() OVER ORDER BY tổng điểm DESC)
  - Map chứa: stagesParticipated, totalPoints, rank

### 2.6 ResultDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới kết quả đua**

#### Phương thức updateResult(int registerId, Integer lapsCompleted, Time timedone, Integer points)
- **Tham số truyền vào**: 
  - `registerId` (int) - ID của đăng ký thi đấu
  - `lapsCompleted` (Integer) - Số vòng đua hoàn thành (nullable)
  - `timedone` (Time) - Thời gian hoàn thành (nullable)
  - `points` (Integer) - Điểm (deprecated, không sử dụng)
- **Giá trị trả về**: `boolean` - true nếu cập nhật thành công
- **Chức năng**: 
  - Cập nhật laps_completed và timedone vào bảng tblregister
  - KHÔNG cập nhật points vào database (chỉ tính toán trong stat tables)

#### Phương thức calculateAndUpdatePointsForStage(int stageId)
- **Tham số truyền vào**: 
  - `stageId` (int) - ID của chặng đua
- **Giá trị trả về**: `boolean` - true nếu tính toán thành công
- **Chức năng**: 
  - Lấy thông tin chặng (total_laps, seasonId)
  - Gọi `updateTeamStatsForStage()` để cập nhật điểm team theo chặng
  - Gọi `updateTeamStatsForSeason()` để cập nhật điểm team theo mùa giải
  - Hệ thống điểm: 1st=25, 2nd=18, 3rd=15, 4th=12, 5th=10, 6th=8, 7th=6, 8th=4, 9th=2, 10th=1

#### Phương thức updateTeamStatsForStage(int stageId, int totalLaps) - PRIVATE
- **Tham số truyền vào**: 
  - `stageId` (int) - ID của chặng đua
  - `totalLaps` (int) - Tổng số vòng đua của chặng
- **Giá trị trả về**: `boolean` - true nếu thành công
- **Chức năng**: 
  - DELETE dữ liệu cũ trong tblstatteaminstage cho chặng này
  - Tính điểm từng racer dựa trên vị trí (rank theo timedone)
  - Tổng hợp điểm theo team
  - INSERT vào tblstatteaminstage (tblTeamid, tblStageid, totalpoints)
  - Chỉ lưu teams có totalpoints > 0

#### Phương thức updateTeamStatsForSeason(int seasonId) - PRIVATE
- **Tham số truyền vào**: 
  - `seasonId` (int) - ID của mùa giải
- **Giá trị trả về**: `boolean` - true nếu thành công
- **Chức năng**: 
  - DELETE dữ liệu cũ trong tblstatteaminseason cho mùa giải này
  - Tổng hợp điểm từ tblstatteaminstage của tất cả stages trong season
  - INSERT vào tblstatteaminseason (tblTeamid, tblSeasonid, totalpoints)
  - Chỉ lưu teams có totalpoints > 0

### 2.7 RegisterDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đăng ký thi đấu**

#### Phương thức getRegistersByStage(int stageId)
- **Tham số truyền vào**: 
  - `stageId` (int) - ID của chặng đua
- **Giá trị trả về**: `List<Register>` - Danh sách đăng ký thi đấu với kết quả
- **Chức năng**: 
  - Lấy tất cả racers đã đăng ký thi đấu trong chặng
  - JOIN nhiều bảng: tblregister, tblcontract, tblracer, tblmember, tblteam, tblstage
  - Tạo đầy đủ đối tượng Register với:
    - Contract (chứa Racer và Team)
    - Stage
    - Result (lapsCompleted, timedone, points)
  - Sắp xếp theo: hoàn thành đủ vòng đầu tiên, timedone ASC, laps_completed DESC, tên
  - Dùng để hiển thị danh sách racers trong form cập nhật kết quả

---

### 2.8 MemberDAO
**Lớp thao tác với cơ sở dữ liệu liên quan tới đối tượng Member (tất cả user/admin chung)**

#### Phương thức getMemberById(int memberId)
- **Tham số truyền vào**: `memberId` (int) - ID của member
- **Giá trị trả về**: `Member` - đối tượng Member
- **Chức năng**: Lấy thông tin cơ bản của member từ `tblmember` (username, name, email,...)

#### Phương thức createMember(Member m)
- **Tham số truyền vào**: `m` (Member) - đối tượng member mới
- **Giá trị trả về**: `boolean` - true nếu tạo thành công
- **Chức năng**: Chèn một record mới vào `tblmember` và trả về kết quả

#### Phương thức updateMember(Member m)
- **Tham số truyền vào**: `m` (Member) - đối tượng member đã sửa
- **Giá trị trả về**: `boolean` - true nếu cập nhật thành công
- **Chức năng**: Cập nhật các trường thông tin (name, email, address, phonenumber, dob)

#### Phương thức deleteMember(int memberId)
- **Tham số truyền vào**: `memberId` (int)
- **Giá trị trả về**: `boolean` - true nếu xóa thành công
- **Chức năng**: Đánh dấu `status=false` hoặc xóa vật lý record (tuỳ chính sách dự án)

#### Phương thức checkLogin(String username, String password)
- **Tham số truyền vào**: `username`, `password`
- **Giá trị trả về**: `Member` hoặc `null` - Member nếu đăng nhập hợp lệ
- **Chức năng**: Kiểm tra thông tin đăng nhập, tránh SQL injection (prepared statements), dùng để phân quyền

---

### 2.9 UserDAO
**Lớp thao tác với phần thông tin chuyên biệt cho người dùng (không phải admin)**

#### Phương thức getUserInfo(int memberId)
- **Tham số truyền vào**: `memberId` (int)
- **Giá trị trả về**: `Map<String,Object>` hoặc `User` - thông tin profile user
- **Chức năng**: Lấy thông tin mở rộng của user (role-specific), ví dụ profile, setting

#### Phương thức updateUserProfile(User u)
- **Tham số truyền vào**: `u` (User)
- **Giá trị trả về**: `boolean` - true nếu cập nhật thành công
- **Chức năng**: Cập nhật các trường thuộc profile người dùng bình thường

---

### 2.10 AdminDAO
**Lớp thao tác với phần thông tin chuyên biệt cho admin**

#### Phương thức getAdminInfo(int memberId)
- **Tham số truyền vào**: `memberId` (int)
- **Giá trị trả về**: `Map<String,Object>` hoặc `Admin` - thông tin admin
- **Chức năng**: Lấy các thông tin liên quan đến quyền hạn/thiết lập admin, dùng để điều hướng giao diện admin

#### Phương thức listManagedStages(int adminId)
- **Tham số truyền vào**: `adminId` (int)
- **Giá trị trả về**: `List<Stage>` - danh sách chặng mà admin được phân quyền quản lý (nếu có)
- **Chức năng**: Hỗ trợ các tính năng quản lý (nếu dự án có phân quyền chi tiết)

---

## 3. Tầng Model (Model Classes)

### 3.1 Member
**Lớp đại diện cho thành viên trong hệ thống**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID duy nhất
  - `username` (String) - Tên đăng nhập
  - `name` (String) - Tên đầy đủ
  - `password` (String) - Mật khẩu
  - `dob` (Date) - Ngày sinh
  - `address` (String) - Địa chỉ
  - `email` (String) - Email
  - `phonenumber` (String) - Số điện thoại
  - `role` (String) - Vai trò: "ADMIN" hoặc "USER"
- **Chức năng**: Lớp cơ sở cho Admin, User, và Racer

### 3.2 Admin
**Lớp đại diện cho quản trị viên**

- **Package**: `model`
- **Kế thừa**: Member
- **Chức năng**: Đại diện cho người dùng có quyền admin (quản lý chặng đua, cập nhật kết quả)

### 3.3 User
**Lớp đại diện cho người dùng thường**

- **Package**: `model`
- **Kế thừa**: Member
- **Chức năng**: Đại diện cho người dùng xem thông tin (không có quyền chỉnh sửa)

### 3.4 Racer
**Lớp đại diện cho tay đua**

- **Package**: `model`
- **Kế thừa**: User
- **Thuộc tính bổ sung**:
  - `nationality` (String) - Quốc tịch
  - `shirtnumber` (int) - Số áo đua
  - `status` (boolean) - Trạng thái hoạt động
- **Chức năng**: Đại diện cho tay đua tham gia giải đấu

### 3.5 Team
**Lớp đại diện cho đội đua**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID đội
  - `name` (String) - Tên đội
  - `description` (String) - Mô tả
  - `nation` (String) - Quốc gia
  - `totalpoints` (int) - Tổng điểm (deprecated - tính từ stat tables)
  - `status` (boolean) - Trạng thái hoạt động
- **Chức năng**: Đại diện cho một đội đua xe đạp

### 3.6 Season
**Lớp đại diện cho mùa giải**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID mùa giải
  - `name` (String) - Tên mùa giải (ví dụ: "Tour de France")
  - `year` (int) - Năm tổ chức
  - `description` (String) - Mô tả
  - `startdate` (Date) - Ngày bắt đầu
  - `enddate` (Date) - Ngày kết thúc
- **Chức năng**: Đại diện cho một mùa giải đua xe đạp

### 3.7 Stage
**Lớp đại diện cho chặng đua**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID chặng đua
  - `name` (String) - Tên chặng
  - `date` (Date) - Ngày thi đấu
  - `location` (String) - Địa điểm
  - `description` (String) - Mô tả
  - `roadmap` (String) - Lộ trình
  - `totalLaps` (int) - Tổng số vòng đua
  - `status` (boolean) - Trạng thái
  - `seasonId` (int) - ID mùa giải (FK)
- **Chức năng**: Đại diện cho một chặng đua trong mùa giải

### 3.8 Contract
**Lớp đại diện cho hợp đồng tay đua - đội**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID hợp đồng
  - `salary` (float) - Lương
  - `startdate` (Date) - Ngày bắt đầu
  - `enddate` (Date) - Ngày kết thúc
  - `status` (boolean) - Trạng thái hợp đồng
  - `racer` (Racer) - Tay đua
  - `team` (Team) - Đội đua
- **Chức năng**: Liên kết tay đua với đội trong một khoảng thời gian

### 3.9 Register
**Lớp đại diện cho đăng ký thi đấu**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID đăng ký
  - `dateRegistered` (Date) - Ngày đăng ký
  - `status` (boolean) - Trạng thái
  - `contract` (Contract) - Hợp đồng (chứa Racer và Team)
  - `stage` (Stage) - Chặng đua
  - `result` (Result) - Kết quả thi đấu
- **Chức năng**: Đại diện cho việc một tay đua đăng ký tham gia một chặng đua

### 3.10 Result
**Lớp đại diện cho kết quả thi đấu**

- **Package**: `model`
- **Thuộc tính**:
  - `id` (int) - ID kết quả
  - `lapsCompleted` (int) - Số vòng đã hoàn thành
  - `timedone` (Time) - Thời gian hoàn thành
- **Chức năng**: Lưu kết quả thi đấu của tay đua trong một chặng (không lưu points - tính trong stat tables)

---

## 4. Luồng xử lý chính

## 4. Luồng xử lý chính

### 4.0 Luồng đăng nhập (Authentication Flow)

```
User truy cập → index.jsp
  ├→ Kiểm tra session
  │   ├→ Có admin session → admin/adminHome.jsp
  │   ├→ Có user session → user/userHome.jsp
  │   └→ Không có session → login.jsp
  ↓
login.jsp
  ├→ Hiển thị form đăng nhập
  └→ Submit username, password
  ↓
doLogin.jsp
  ├→ Tạo Member object với username, password
  ├→ MemberDAO.checkLogin(member)
  │   ├→ Validate SQL injection
  │   ├→ Query: JOIN tblmember, tbluser, tbladmin
  │   ├→ Xác định role (ADMIN/USER)
  │   ├→ Gọi AdminDAO.getAdminInfo() nếu ADMIN
  │   └→ Gọi UserDAO.getUserInfo() nếu USER
  ├→ Invalidate old session, create new session
  ├→ Set session.admin hoặc session.user
  └→ Redirect theo role
      ├→ ADMIN → admin/adminHome.jsp
      ├→ USER → user/userHome.jsp
      └→ Failed → login.jsp?error=failed
```

### 4.1 Luồng xem bảng xếp hạng theo Mùa giải

```
User → userHome.jsp
  ↓
chooseTypeRanking.jsp (chọn "View by Season")
  ↓
chooseSeason.jsp
  ├→ SeasonDAO.getAllSeasons()
  └→ Hiển thị danh sách Season
  ↓
User chọn Season
  ↓
teamRanking.jsp?seasonId=X
  ├→ SeasonDAO.getSeasonById(seasonId)
  ├→ TeamDAO.getTeamRankingsBySeason(seasonId)
  │   ├→ SELECT FROM tblstatteaminseason
  │   └→ Sắp xếp theo totalpoints DESC, tính rank
  └→ Hiển thị bảng xếp hạng
  ↓
User click "View Details"
  ↓
teamDetail.jsp?teamId=Y&seasonId=X
  ├→ TeamDAO.getTeamById(teamId)
  ├→ TeamDAO.getTeamSeasonStats(teamId, seasonId)
  ├→ TeamDAO.getRacersByTeam(teamId, seasonId)
  ├→ TeamDAO.getTeamPerformanceByStage(teamId, seasonId)
  └→ Hiển thị chi tiết đội
  ↓
User click "View racer details"
  ↓
racerDetail.jsp?racerId=Z&seasonId=X
  ├→ RacerDAO.getRacerById(racerId)
  ├→ RacerDAO.getRacerResults(racerId, seasonId)
  ├→ RacerDAO.getRacerStats(racerId, seasonId)
  └→ Hiển thị chi tiết tay đua
```

### 4.2 Luồng xem bảng xếp hạng theo Chặng đua

```
User → userHome.jsp
  ↓
chooseTypeRanking.jsp (chọn "View by Stage")
  ↓
chooseRace.jsp
  ├→ SeasonDAO.getAllSeasons()
  ├→ StageDAO.getStagesBySeason(seasonId) (cho mỗi season)
  └→ Hiển thị danh sách Stage theo Season
  ↓
User chọn Stage
  ↓
teamRanking.jsp?stageId=X
  ├→ StageDAO.getStageInfo(stageId)
  ├→ TeamDAO.getTeamRankingsByStage(stageId)
  │   ├→ SELECT FROM tblstatteaminstage
  │   └→ Sắp xếp theo totalpoints DESC, tính rank
  └→ Hiển thị bảng xếp hạng
  ↓
User click "View Details"
  ↓
teamDetail.jsp?teamId=Y&stageId=X
  ├→ TeamDAO.getTeamById(teamId)
  ├→ StageDAO.getStageInfo(stageId)
  ├→ TeamDAO.getTeamRacersInStage(teamId, stageId)
  └→ Hiển thị chi tiết đội trong chặng
```

### 4.3 Luồng Admin cập nhật kết quả

```
Admin → adminHome.jsp
  ↓
stageList.jsp
  ├→ StageDAO.getAllStages()
  └→ Hiển thị danh sách chặng
  ↓
Admin chọn Stage để cập nhật
  ↓
updateResult.jsp?stageId=X
  ├→ StageDAO.getStageInfo(stageId)
  ├→ RegisterDAO.getRegistersByStage(stageId)
  └→ Hiển thị form nhập kết quả
  ↓
Admin nhập laps_completed, timedone
  ↓
doUpdateResult.jsp
  ├→ Nhận parameters từ form
  ├→ ResultDAO.updateResult(registerId, lapsCompleted, timedone, null)
  │   └→ UPDATE tblregister
  ├→ ResultDAO.calculateAndUpdatePointsForStage(stageId)
  │   ├→ Tính điểm tay đua theo rank (1st=25, 2nd=18, ...)
  │   ├→ Tổng hợp điểm theo team
  │   ├→ DELETE + INSERT vào tblstatteaminstage
  │   └→ DELETE + INSERT vào tblstatteaminseason
  └→ Redirect về stageList.jsp với thông báo thành công
```

### 4.4 Luồng tìm kiếm chặng đua

```
User → userHome.jsp
  ↓
searchStage.jsp
  └→ Hiển thị form tìm kiếm
  ↓
User nhập keyword
  ↓
doSearchStage.jsp
  ├→ Nhận parameter keyword
  ├→ StageDAO.searchStage(keyword)
  │   └→ SELECT WHERE name LIKE '%keyword%' OR location LIKE '%keyword%' OR description LIKE '%keyword%'
  ├→ Lưu kết quả vào session.stageList
  └→ Redirect đến stageListSearch.jsp
  ↓
stageListSearch.jsp
  ├→ Lấy stageList từ session
  └→ Hiển thị kết quả tìm kiếm
  ↓
User click vào một stage
  ↓
stageDetail.jsp?stageId=X
  ├→ StageDAO.getStageInfo(stageId)
  ├→ TeamDAO.getTeamRankingsByStage(stageId)
  └→ Hiển thị chi tiết chặng và BXH
```

---

## 5. Cấu trúc cơ sở dữ liệu chính

### Bảng thống kê (Stat Tables)

#### tblstatteaminseason
- **Mục đích**: Lưu thống kê điểm đội theo mùa giải
- **Cấu trúc**:
  - `tblTeamid` (int) - FK → tblteam
  - `tblSeasonid` (int) - FK → tblseason
  - `totalpoints` (int) - Tổng điểm đội trong mùa giải
- **Cách sử dụng**: Đọc để hiển thị BXH theo mùa, sắp xếp theo totalpoints DESC

#### tblstatteaminstage
- **Mục đích**: Lưu thống kê điểm đội theo chặng đua
- **Cấu trúc**:
  - `tblTeamid` (int) - FK → tblteam
  - `tblStageid` (int) - FK → tblstage
  - `totalpoints` (int) - Tổng điểm đội trong chặng
- **Cách sử dụng**: Đọc để hiển thị BXH theo chặng, sắp xếp theo totalpoints DESC

### Bảng chính (Main Tables)

#### tblseason
- `id`, `name`, `year`, `startdate`, `enddate`, `totalpoints`

#### tblstage
- `id`, `name`, `date`, `location`, `description`, `roadmap`, `total_laps`, `status`, `tblSeasonid`

#### tblteam
- `id`, `name`, `description`, `nation`, `totalpoints`, `status`

#### tblracer
- `id`, `nationality`, `shirtnumber`, `status`, `tblMemberid`

#### tblregister
- `id`, `dateregistered`, `status`, `laps_completed`, `timedone`, `tblContractid`, `tblStageid`

#### tblcontract
- `id`, `salary`, `startdate`, `enddate`, `status`, `tblRacerid`, `tblTeamid`

---

## 6. Hệ thống tính điểm

### Điểm cá nhân (Individual Points)
- **1st place**: 25 điểm
- **2nd place**: 18 điểm
- **3rd place**: 15 điểm
- **4th place**: 12 điểm
- **5th place**: 10 điểm
- **6th place**: 8 điểm
- **7th place**: 6 điểm
- **8th place**: 4 điểm
- **9th place**: 2 điểm
- **10th place**: 1 điểm
- **DNF (Did Not Finish)**: 0 điểm

### Điểm đội (Team Points)
- Tổng điểm = Tổng điểm của tất cả tay đua trong đội
- Rank đội = Sắp xếp theo tổng điểm giảm dần (không lưu trong DB, tính khi query)

---

## 7. Quy ước đặt tên

### JSP Files
- `gdXXX.jsp` hoặc `xxxPage.jsp` - Trang hiển thị giao diện
- `doXXX.jsp` - Trang xử lý logic (action)

### DAO Classes
- `XxxDAO.java` - Lớp thao tác với đối tượng Xxx
- Phương thức bắt đầu bằng: `get`, `update`, `delete`, `create`, `calculate`

### Database Tables
- `tblxxx` - Bảng chính
- `tblstatxxx` - Bảng thống kê (statistics)

### Parameters
- `xxxId` - ID của đối tượng (int)
- `keyword` - Từ khóa tìm kiếm (String)
- Return: `List<Xxx>`, `Map<String, Object>`, `Xxx`, `boolean`
