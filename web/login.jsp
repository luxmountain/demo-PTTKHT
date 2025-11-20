<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/style.css">
        <style>
            .login-container {
                max-width: 450px;
                margin: 100px auto;
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }
            
            .error-message {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                border-left: 5px solid #dc3545;
            }
            
            input[type="submit"] {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }
            
            input[type="password"] {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                margin-top: 5px;
                transition: border-color 0.3s ease;
            }
            
            input[type="password"]:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }
        </style>
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
                } else if (request.getParameter("err") != null) {
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
