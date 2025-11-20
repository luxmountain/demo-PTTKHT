<%-- 
    Document   : doSearchStage
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*, dao.*, model.*" %>
<%
    Member user = (Member) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../login.jsp?error=timeout");
        return;
    }

    String keyword = request.getParameter("keyword");
    
    if (keyword == null || keyword.trim().isEmpty()) {
        response.sendRedirect("searchStage.jsp?error=empty");
        return;
    }

    StageDAO stageDAO = new StageDAO();
    List<Stage> stages = stageDAO.searchStage(keyword.trim());
    
    // Store search results in session
    session.setAttribute("searchResults", stages);
    session.setAttribute("searchKeyword", keyword);
    
    // Redirect to results page
    response.sendRedirect("stageListSearch.jsp");
%>
