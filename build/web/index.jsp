<%-- 
    Document   : index
    Created on : Nov 20, 2025
    Author     : ADMIN
    Purpose    : Route users based on session and role
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<%
    // Check if user has a session
    Member admin = (Member) session.getAttribute("admin");
    Member user = (Member) session.getAttribute("user");
    
    if (admin != null) {
        // Admin is logged in, redirect to admin home
        response.sendRedirect("admin/adminHome.jsp");
    } else if (user != null) {
        // User is logged in, redirect to user home
        response.sendRedirect("user/userHome.jsp");
    } else {
        // No session, redirect to login page
        response.sendRedirect("login.jsp");
    }
%>
