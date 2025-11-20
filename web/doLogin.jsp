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

    MemberDAO memberDAO = new MemberDAO();
    Member authenticatedMember = memberDAO.checkLogin(member);

    if (authenticatedMember != null) {
        if (session != null) {
            session.invalidate();
            session = request.getSession(true);
        }

        String role = authenticatedMember.getRole();

        if ("ADMIN".equals(role)) {
            session.setAttribute("admin", authenticatedMember);
            response.sendRedirect("admin/adminHome.jsp");
        } else if ("USER".equals(role)) {
            session.setAttribute("user", authenticatedMember);
            response.sendRedirect("user/userHome.jsp");
        } else {
            response.sendRedirect("login.jsp?error=failed");
        }
    } else {
        response.sendRedirect("login.jsp?error=failed");
    }
%>