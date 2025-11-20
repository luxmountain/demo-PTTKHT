<%-- 
    Document   : userHome
    Created on : Nov 20, 2025, 10:37:10 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Home</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?err=timeout");
            } else {
        %>
        <div class="container">
            <h1>Home</h1>
            
            <div class="user-info">
                <strong>Name:</strong> <%= user.getName() %>
            </div>
            
            <div class="menu-grid">
                <a href="searchStage.jsp" class="menu-card">
                    <h3>Search Race</h3>
                    <p>Tìm kiếm thông tin chặng đua</p>
                </a>
                <a href="teamRanking.jsp" class="menu-card">
                    <h3>Team Rankings</h3>
                    <p>Xem bảng xếp hạng các đội đua</p>
                </a>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
