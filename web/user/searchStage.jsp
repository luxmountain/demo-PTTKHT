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
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?err=timeout");
                return;
            }
        %>
        
        <div class="search-container">
            <h2>Search</h2>
            
            <form action="doSearchStage.jsp" method="post">
                <div class="form-group">
                    <label for="keyword">Keyword</label>
                    <input type="text" id="keyword" name="keyword" required>
                </div>
                
                <div class="button-group">
                    <button type="submit">Search</button>
                </div>
            </form>
        </div>
    </body>
</html>
