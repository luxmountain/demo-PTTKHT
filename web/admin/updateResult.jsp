<%-- 
    Document   : updateResult
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật kết quả chặng đua</title>
        <link rel="stylesheet" href="../css/style.css">
        <script>
            function validateForm() {
                var inputs = document.querySelectorAll('input[type="number"], input[type="time"]');
                var hasData = false;
                
                for (var i = 0; i < inputs.length; i++) {
                    if (inputs[i].value !== '') {
                        hasData = true;
                        break;
                    }
                }
                
                if (!hasData) {
                    alert('Vui lòng nhập ít nhất một kết quả!');
                    return false;
                }
                
                // Validate that if position is entered, time should also be entered
                var rows = document.querySelectorAll('tbody tr');
                for (var i = 0; i < rows.length; i++) {
                    var position = rows[i].querySelector('input[name^="position"]').value;
                    var time = rows[i].querySelector('input[name^="time"]').value;
                    
                    if (position !== '' && time === '') {
                        alert('Vui lòng nhập thời gian hoàn thành cho tay đua có thứ hạng ' + position);
                        return false;
                    }
                }
                
                return confirm('Bạn có chắc chắn muốn lưu kết quả này?');
            }
        </script>
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?err=timeout");
                return;
            }

            String stageIdStr = request.getParameter("stageId");
            if (stageIdStr == null || stageIdStr.trim().isEmpty()) {
                response.sendRedirect("stageList.jsp");
                return;
            }

            int stageId = Integer.parseInt(stageIdStr);
            
            StageDAO stageDAO = new StageDAO();
            Stage stage = stageDAO.getStageInfo(stageId);
            
            if (stage == null) {
                response.sendRedirect("stageList.jsp");
                return;
            }
            
            ResultDAO resultDAO = new ResultDAO();
            List<Register> registers = resultDAO.getRegistersByStage(stageId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date today = new Date();
            
            String statusText = "";
            String statusBadge = "";
            
            if (stage.getDate() != null) {
                if (stage.getDate().before(today)) {
                    statusText = "Đã hoàn thành";
                    statusBadge = "completed";
                } else {
                    statusText = "Chưa diễn ra";
                    statusBadge = "upcoming";
                }
            } else {
                statusText = "Chưa xác định";
                statusBadge = "upcoming";
            }
        %>
        
        <div class="container">
            <a href="stageList.jsp" class="back-button">← Quay lại danh sách chặng đua</a>
            
            <h1>Cập nhật kết quả chặng đua</h1>
            
            <div class="stage-info">
                <p><strong>Tên chặng đua:</strong> <%= stage.getName() %></p>
                <p><strong>Ngày tổ chức:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></p>
                <p><strong>Địa điểm:</strong> <%= stage.getLocation() %></p>
                <p><strong>Trạng thái:</strong> <span class="badge badge-<%= statusBadge %>"><%= statusText %></span></p>
            </div>
            
            <% if (registers == null || registers.isEmpty()) { %>
                <div class="card">
                    <p style="color: #dc3545;">Không có tay đua nào đăng ký tham gia chặng đua này.</p>
                </div>
                <div class="button-group">
                    <a href="stageList.jsp" class="back-button">Quay lại</a>
                </div>
            <% } else { %>
            
            <form action="doUpdateResult.jsp" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="stageId" value="<%= stageId %>">
                
                <table>
                    <thead>
                        <tr>
                            <th>Tên tay đua</th>
                            <th>Đội đua</th>
                            <th>Thứ hạng</th>
                            <th>Thời gian hoàn thành</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        for (int i = 0; i < registers.size(); i++) {
                            Register register = registers.get(i);
                            Result result = register.getResult();
                            String timeValue = "";
                            if (result != null && result.getTimedone() != null) {
                                timeValue = result.getTimedone().toString();
                            }
                            Integer position = (result != null) ? result.getPosition() : null;
                        %>
                        <tr>
                            <td>
                                <%= register.getRacerName() %>
                                <input type="hidden" name="registerId_<%= i %>" value="<%= register.getId() %>">
                            </td>
                            <td><%= register.getTeamName() %></td>
                            <td>
                                <input type="number" 
                                       name="position_<%= i %>" 
                                       min="1" 
                                       value="<%= position != null ? position : "" %>"
                                       placeholder="Nhập thứ hạng">
                            </td>
                            <td>
                                <input type="time" 
                                       name="time_<%= i %>" 
                                       step="1"
                                       value="<%= timeValue %>"
                                       placeholder="HH:MM:SS">
                            </td>
                        </tr>
                        <% } %>
                        <input type="hidden" name="racerCount" value="<%= registers.size() %>">
                    </tbody>
                </table>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Lưu kết quả</button>
                    <a href="stageList.jsp" class="back-button">Hủy bỏ</a>
                </div>
            </form>
            
            <% } %>
        </div>
    </body>
</html>
