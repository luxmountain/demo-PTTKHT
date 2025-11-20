<%-- 
    Document   : index
    Created on : Nov 20, 2025
    Author     : ADMIN
    Purpose    : Route users based on session and role
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<%
    Member admin = (Member) session.getAttribute("admin");
    Member user = (Member) session.getAttribute("user");
    
    if (admin != null) {
        response.sendRedirect("admin/adminHome.jsp");
    } else if (user != null) {
        response.sendRedirect("user/userHome.jsp");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
