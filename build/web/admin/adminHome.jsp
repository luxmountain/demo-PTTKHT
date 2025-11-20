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
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?err=timeout");
            } else {
        %>
        <div class="container">
            <h2>Trang quản trị</h2>
            
            <div class="welcome">
                <p><strong>Xin chào, <%= admin.getName() %>!</strong></p>
                <p>Vai trò: Quản trị viên</p>
            </div>
            
            <div class="menu">
                <h3>Chức năng quản lý</h3>
                <a href="stageList.jsp" class="menu-item">📊 Cập nhật kết quả chặng đua</a>
                <!-- Add more menu items here as needed -->
            </div>
            
            <a href="../login.jsp" class="logout">Đăng xuất</a>
        </div>
        <%
            }
        %>
    </body>
</html>
