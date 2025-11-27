<%-- 
    Document   : doAddStage
    Created on : Nov 27, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.text.SimpleDateFormat,java.util.Date" %>
<%
    Member admin = (Member) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../login.jsp?error=timeout");
        return;
    }

    try {
        // Get form parameters
        String name = request.getParameter("name");
        String dateStr = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String roadmap = request.getParameter("roadmap");
        String totalLapsStr = request.getParameter("totalLaps");
        String seasonIdStr = request.getParameter("seasonId");
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
            dateStr == null || dateStr.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            totalLapsStr == null || totalLapsStr.trim().isEmpty() ||
            seasonIdStr == null || seasonIdStr.trim().isEmpty()) {
            response.sendRedirect("addStage.jsp?error=true&errorMsg=All required fields must be filled!");
            return;
        }
        
        // Parse parameters
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date stageDate = sdf.parse(dateStr);
        int totalLaps = Integer.parseInt(totalLapsStr);
        int seasonId = Integer.parseInt(seasonIdStr);
        
        // Validate total laps
        if (totalLaps <= 0) {
            response.sendRedirect("addStage.jsp?error=true&errorMsg=Total laps must be greater than 0!");
            return;
        }
        
        // Create Stage object
        Stage stage = new Stage();
        stage.setName(name.trim());
        stage.setDate(new java.sql.Date(stageDate.getTime()));
        stage.setLocation(location.trim());
        stage.setDescription(description != null && !description.trim().isEmpty() ? description.trim() : null);
        stage.setRoadmap(roadmap != null && !roadmap.trim().isEmpty() ? roadmap.trim() : null);
        stage.setTotalLaps(totalLaps);
        stage.setStatus(true); // Active by default
        stage.setSeasonId(seasonId);
        
        // Add stage to database
        StageDAO stageDAO = new StageDAO();
        boolean success = stageDAO.addStage(stage);
        
        if (success) {
            response.sendRedirect("stageList.jsp?msg=addStageSuccess");
        } else {
            response.sendRedirect("addStage.jsp?error=true&errorMsg=Failed to add stage to database!");
        }
        
    } catch (NumberFormatException e) {
        response.sendRedirect("addStage.jsp?error=true&errorMsg=Invalid number format!");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("addStage.jsp?error=true&errorMsg=" + e.getMessage());
    }
%>
