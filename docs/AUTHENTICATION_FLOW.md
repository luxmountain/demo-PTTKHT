## Authentication flow (Mô tả luồng xác thực)

Tài liệu này mô tả cách authentication/authorization đang hoạt động trong project và nơi các kiểm tra phiên (session) được thực hiện.

### 1) Form login
- File: `web/login.jsp`
- Người dùng nhập `username` và `password` và form được submit tới `web/doLogin.jsp` (POST).

### 2) Xử lý login
- File: `web/doLogin.jsp`
- Bước chính:
  1. Lấy `username`/`password` từ `request`.
  2. Tạo `Member` tạm và gọi `MemberDAO.checkLogin(member)`.
  3. Nếu `authenticatedMember != null`:
     - Nếu tồn tại `session`, **invalidate()** rồi tạo session mới: `session = request.getSession(true)`.
     - Lấy `role` từ `authenticatedMember.getRole()`.
     - Nếu `role == "ADMIN"` → `session.setAttribute("admin", authenticatedMember)` và redirect tới `admin/adminHome.jsp`.
     - Nếu `role == "USER"` → `session.setAttribute("user", authenticatedMember)` và redirect tới `user/userHome.jsp`.
     - Ngược lại redirect về `login.jsp?error=failed`.
  4. Nếu `authenticatedMember == null` → redirect về `login.jsp?error=failed`.

### 3) Xác thực trong các trang (session checks)
- Các trang dành cho admin thường kiểm tra: `Member admin = (Member) session.getAttribute("admin");` và nếu `admin == null` thì `response.sendRedirect("../login.jsp?err=timeout");`.
- Các trang dành cho user kiểm tra: `Member user = (Member) session.getAttribute("user");` và nếu `user == null` thì redirect về `../login.jsp?err=timeout`.
- Ví dụ các file có check: 
  - `web/admin/updateResult.jsp`
  - `web/admin/stageList.jsp`
  - `web/user/userHome.jsp`
  - `web/user/stageDetail.jsp` (và nhiều trang user khác)

### 4) Trang index / routing dựa trên session
- File: `web/index.jsp` — nếu `admin` tồn tại redirect tới `/admin/adminHome.jsp`; nếu `user` tồn tại redirect tới `/user/userHome.jsp`; nếu không có session → redirect tới `login.jsp`.

### 5) Logout
- Hiện tại project không có endpoint logout riêng. Các trang `userHome.jsp` và `adminHome.jsp` có link `Logout` trỏ về `../login.jsp`.
- Điều này chỉ chuyển về trang login mà không call `session.invalidate()` — nghĩa là session vẫn còn trên server nếu chưa hết hạn.

### 6) Xác thực ở tầng DAO
- `src/java/dao/MemberDAO.java` — phương thức `checkLogin(Member)`:
  - Kiểm tra nhanh một số ký tự (nếu username/password chứa `true` hoặc `=` thì trả về null).
  - Chạy query SQL để xác định role (`ADMIN` hoặc `USER`) bằng cách `LEFT JOIN` vào `tbladmin` và `tbluser`.
  - Sau khi biết role, gọi `AdminDAO.getAdminInfo(memberId)` hoặc `UserDAO.getUserInfo(memberId)` để build đối tượng `Member` trả về.

### 7) Những vấn đề & đề xuất cải tiến
- Passwords lưu và so sánh ở dạng plain-text trong DB (query dùng `m.password = ?`). Nên thay bằng hashing (BCrypt/Argon2) và so sánh hash.
- `doLogin.jsp` đang invalidate session và tạo session mới, đó là tốt — nhưng không có centralized logout.
- Nên thêm trang/servlet `logout.jsp` hoặc `LogoutServlet` để gọi `session.invalidate()`.
- Hiện các trang tự kiểm tra session; nên cân nhắc dùng Servlet Filter (ví dụ `AuthFilter`) để kiểm tra session/role chung cho các URL pattern (`/admin/*`, `/user/*`).
- Kiểm soát CSRF cho form (token) nếu có thay đổi trạng thái (ví dụ update results).
- Tăng cường kiểm tra SQL injection: `MemberDAO` đã dùng `CallableStatement` với placeholders, nhưng có một số check chuỗi thủ công (những check này không đủ). Sử dụng prepared statements/parameterized queries (đang dùng nhưng vẫn lưu mật khẩu plain-text).

### 8) Liên kết file tham khảo
- `web/login.jsp` — form
- `web/doLogin.jsp` — handler (session create + setAttribute)
- `src/java/dao/MemberDAO.java` — xác thực + lấy role
- `web/index.jsp` — route sau login
- `web/admin/*.jsp` và `web/user/*.jsp` — check session attribute

---
Nếu bạn muốn, tôi có thể:
- Thêm `docs/quick-fixes.md` với các bước thực hiện: (1) tạo `LogoutServlet`, (2) chuyển so sánh mật khẩu sang BCrypt, (3) thêm `AuthFilter` và (4) sửa các liên kết logout để gọi `LogoutServlet`.

