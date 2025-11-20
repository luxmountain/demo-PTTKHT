<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
            if (request.getParameter("error") != null && request.getParameter("error").equalsIgnoreCase("timeout")) {
        %>
                <h4>Session timed out. Please log in again.</h4>
        <%
            } else if (request.getParameter("error") != null && request.getParameter("error").equalsIgnoreCase("failed")) {
        %>
                <h4>Login failed. Please check your username and password.</h4>
        <%
            }
        %>
        <h1>Login</h1>
        <form action="doLogin.jsp" method="post" name="loginForm">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <input type="submit" value="Login">
        </form>
    </body>
</html>
