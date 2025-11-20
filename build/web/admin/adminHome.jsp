<%-- 
    Document   : adminHome
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?err=timeout");
            } else {
        %>
        <div class="container">
            <h1>Trang quản trị</h1>
            
            <div class="user-info">
                <p><strong>Xin chào, <%= admin.getName() %>!</strong></p>
                <p>Vai trò: Quản trị viên</p>
            </div>
            
            <div class="menu-grid">
                <a href="stageList.jsp" class="menu-card">
                    <h3>📊 Quản lý kết quả</h3>
                    <p>Cập nhật kết quả chặng đua</p>
                </a>
                <!-- Add more menu items here as needed -->
            </div>
            
            <div class="button-group">
                <a href="../login.jsp" class="back-button">Đăng xuất</a>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
