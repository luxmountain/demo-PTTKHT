<%-- 
    Document   : stageList
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách chặng đua</title>
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?err=timeout");
                return;
            }

            String message = request.getParameter("msg");
            
            StageDAO stageDAO = new StageDAO();
            List<Stage> stages = stageDAO.getAllStages();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date today = new Date();
        %>
        
        <div class="container">
            <a href="adminHome.jsp" class="back-link">← Quay lại trang chủ</a>
            
            <h2>Danh sách chặng đua</h2>
            
            <% if (message != null && message.equals("success")) { %>
                <div class="message">
                    Cập nhật kết quả thành công!
                </div>
            <% } %>
            
            <table>
                <thead>
                    <tr>
                        <th>Tên chặng đua</th>
                        <th>Ngày tổ chức</th>
                        <th>Địa điểm</th>
                        <th>Trạng thái</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (stages != null && !stages.isEmpty()) {
                        for (Stage stage : stages) {
                            String statusText = "";
                            String statusClass = "";
                            
                            if (stage.getDate() != null) {
                                if (stage.getDate().before(today)) {
                                    statusText = "Đã hoàn thành";
                                    statusClass = "status-completed";
                                } else {
                                    statusText = "Chưa diễn ra";
                                    statusClass = "status-upcoming";
                                }
                            } else {
                                statusText = "Chưa xác định";
                                statusClass = "status-upcoming";
                            }
                    %>
                    <tr>
                        <td><%= stage.getName() %></td>
                        <td><%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></td>
                        <td><%= stage.getLocation() %></td>
                        <td class="<%= statusClass %>"><%= statusText %></td>
                        <td>
                            <a href="updateResult.jsp?stageId=<%= stage.getId() %>" class="btn">Cập nhật kết quả</a>
                        </td>
                    </tr>
                    <% 
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center;">Không có chặng đua nào</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>
