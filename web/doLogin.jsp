<%-- 
    Document   : doLogin
    Created on : Nov 18, 2025, 2:12:04 PM
    Author     : ADMIN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,dao.*,model.*"%>
<% 
    String username = (String) request.getParameter("username");
    String password = (String) request.getParameter("password");

    Member member = new Member();
    member.setUsername(username);
    member.setPassword(password);
    

%>