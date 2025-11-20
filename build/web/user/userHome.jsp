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
            User user = (User) session.getAttribute(Role.USER);
            if (user == null) {
                response.sendRedirect("login.jsp?err=timeout");
            }
        %>
        <h2>User Home</h2>
    </body>
</html>
