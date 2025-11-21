<%-- 
    Document   : doUpdateResult
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.sql.Time" %>
<%
    Member admin = (Member) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../login.jsp?error=timeout");
        return;
    }

    String stageIdStr = request.getParameter("stageId");
    String racerCountStr = request.getParameter("racerCount");
    
    if (stageIdStr == null || racerCountStr == null) {
        response.sendRedirect("stageList.jsp");
        return;
    }

    try {
        int stageId = Integer.parseInt(stageIdStr);
        int racerCount = Integer.parseInt(racerCountStr);
        
        ResultDAO resultDAO = new ResultDAO();
        boolean allSuccess = true;
        
        // Get total laps for the stage
        StageDAO stageDAO = new StageDAO();
        Stage stage = stageDAO.getStageInfo(stageId);
        int totalLaps = (stage != null) ? stage.getTotalLaps() : 0;
        
        // Process each racer's result
        for (int i = 0; i < racerCount; i++) {
            String registerIdStr = request.getParameter("registerId_" + i);
            String lapsCompletedStr = request.getParameter("laps_" + i);
            String timeStr = request.getParameter("time_" + i);
            
            if (registerIdStr != null && !registerIdStr.trim().isEmpty()) {
                int registerId = Integer.parseInt(registerIdStr);
                
                // Parse laps completed
                Integer lapsCompleted = null;
                if (lapsCompletedStr != null && !lapsCompletedStr.trim().isEmpty()) {
                    lapsCompleted = Integer.parseInt(lapsCompletedStr);
                }
                
                // Parse time
                Time timedone = null;
                if (timeStr != null && !timeStr.trim().isEmpty()) {
                    try {
                        if (timeStr.length() == 5) {
                            timedone = Time.valueOf(timeStr + ":00");
                        } else if (timeStr.length() == 8) {
                            timedone = Time.valueOf(timeStr);
                        } else if (timeStr.length() == 2) {
                            timedone = Time.valueOf(timeStr + ":00:00");
                        } else {
                            throw new IllegalArgumentException("Invalid time format");
                        }
                    } catch (Exception ex) {
                        // Skip invalid time format
                        ex.printStackTrace();
                    }
                }
                
                // Calculate points based on whether racer finished the race
                // Only award points if laps completed equals total laps
                Integer points = null;
                if (lapsCompleted != null && totalLaps > 0 && lapsCompleted >= totalLaps && timedone != null) {
                    // Points awarded based on finishing order (will be calculated after sorting by time)
                    // For now, just mark as completed - points can be recalculated later
                    points = 0; // Placeholder, actual points depend on final ranking
                }
                
                // Update result if there's data to update
                if (lapsCompleted != null || timedone != null) {
                    boolean success = resultDAO.updateResult(registerId, lapsCompleted, timedone, points);
                    if (!success) {
                        allSuccess = false;
                    }
                }
            }
        }
        
        if (allSuccess) {
            // Redirect back to stage list with success message
            response.sendRedirect("stageList.jsp?msg=success");
        } else {
            // Redirect back to update form with error
            response.sendRedirect("updateResult.jsp?stageId=" + stageId + "&error=update_failed");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("stageList.jsp?error=exception");
    }
%>
