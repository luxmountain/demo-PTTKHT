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
        </div>
        <%
            }
        %>
    </body>
</html>
