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
        <h2>Admin Home</h2>
        <p>Welcome, <%= admin.getName() %>!</p>
        <p>Role: Administrator</p>
        <%
            }
        %>
    </body>
</html>
