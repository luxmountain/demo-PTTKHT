<%-- 
    Document   : searchStage
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Stage</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?error=timeout");
                return;
            }
        %>
        
        <div class="container">
            <h1>Search Race</h1>
            
            <div class="card">
                <form action="doSearchStage.jsp" method="post">
                    <div class="form-group">
                        <label for="keyword">Keyword</label>
                        <input type="text" id="keyword" name="keyword" 
                               placeholder="Enter keyword..." required>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn-primary">Search</button>
                        <a href="userHome.jsp" class="back-button">Back</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
