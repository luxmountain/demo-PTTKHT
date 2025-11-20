<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <div class="login-container">
            <h1>Login</h1>
            
            <%
                if (request.getParameter("error") != null && request.getParameter("error").equalsIgnoreCase("timeout")) {
            %>
                    <div class="error-message">Session timed out. Please log in again.</div>
            <%
                } else if (request.getParameter("error") != null && request.getParameter("error").equalsIgnoreCase("failed")) {
            %>
                    <div class="error-message">Login failed. Please check your username and password.</div>
            <%
                } else if (request.getParameter("error") != null) {
            %>
                    <div class="error-message">Session timeout. Please login again.</div>
            <%
                }
            %>
            
            <form action="doLogin.jsp" method="post" name="loginForm">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <div class="button-group">
                    <input type="submit" value="Login">
                </div>
            </form>
        </div>
    </body>
</html>
