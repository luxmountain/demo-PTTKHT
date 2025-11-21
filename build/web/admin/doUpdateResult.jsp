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
        
        // Process each racer's result
        for (int i = 0; i < racerCount; i++) {
            String registerIdStr = request.getParameter("registerId_" + i);
            String positionStr = request.getParameter("position_" + i);
            String timeStr = request.getParameter("time_" + i);
            
            if (registerIdStr != null && !registerIdStr.trim().isEmpty()) {
                int registerId = Integer.parseInt(registerIdStr);
                
                // Parse position
                Integer position = null;
                if (positionStr != null && !positionStr.trim().isEmpty()) {
                    position = Integer.parseInt(positionStr);
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
                
                // Calculate points based on position (simple points system)
                Integer points = null;
                if (position != null) {
                    // Points system: 1st = 25, 2nd = 18, 3rd = 15, 4th = 12, 5th = 10, 6th = 8, 7th = 6, 8th = 4, 9th = 2, 10th = 1
                    switch (position) {
                        case 1: points = 25; break;
                        case 2: points = 18; break;
                        case 3: points = 15; break;
                        case 4: points = 12; break;
                        case 5: points = 10; break;
                        case 6: points = 8; break;
                        case 7: points = 6; break;
                        case 8: points = 4; break;
                        case 9: points = 2; break;
                        case 10: points = 1; break;
                        default: points = 0; break;
                    }
                }
                
                // Update result only if there's data to update
                if (position != null || timedone != null) {
                    boolean success = resultDAO.updateResult(registerId, position, timedone, points);
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
