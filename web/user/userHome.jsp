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
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .home-container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                text-align: center;
            }
            .user-info {
                background: #e7f3ff;
                padding: 15px;
                border-radius: 5px;
                margin: 20px 0;
                text-align: center;
            }
            .menu-button {
                display: block;
                padding: 15px 20px;
                margin: 10px 0;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                text-align: center;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .menu-button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?err=timeout");
            } else {
        %>
        <div class="home-container">
            <h1>Home</h1>
            
            <div class="user-info">
                <strong>Name:</strong> <%= user.getName() %>
            </div>
            
            <a href="searchStage.jsp" class="menu-button">Search Race</a>
            <a href="teamRanking.jsp" class="menu-button">Xem bảng xếp hạng các đội đua</a>
        </div>
        <%
            }
        %>
    </body>
</html>
