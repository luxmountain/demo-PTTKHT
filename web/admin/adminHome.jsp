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
                response.sendRedirect("../login.jsp?error=timeout");
            } else {
        %>
        <div class="container">
            <h1>Admin Dashboard</h1>
            
            <div class="user-info">
                <p><strong>Hello, <%= admin.getName() %>!</strong></p>
                <p>Role: Administrator</p>
            </div>
            
            <div class="menu-grid">
                <a href="stageList.jsp" class="menu-card">
                    <p>Update Stage Results</p>
                </a>
                <!-- Add more menu items here as needed -->
            </div>
            
            <div class="button-group">
                <a href="../login.jsp" class="back-button">Logout</a>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
