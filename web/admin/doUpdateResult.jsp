<%-- 
    Document   : doUpdateResult
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.sql.Time,java.net.URLEncoder" %>
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
        boolean hadUpdateError = false;
        String redirectErrorMsg = null;
        
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
                // Points will be calculated after all results are updated
                Integer points = null;
                
                // Update result if there's data to update
                if (lapsCompleted != null || timedone != null) {
                    boolean success = resultDAO.updateResult(registerId, lapsCompleted, timedone, points);
                    if (!success) {
                        allSuccess = false;
                        hadUpdateError = true;
                        redirectErrorMsg = "Failed to update some records";
                    }
                }
            }
        }
        
        // After updating all results, calculate points based on finishing order
        if (allSuccess) {
            allSuccess = resultDAO.calculateAndUpdatePointsForStage(stageId);
            if (!allSuccess) {
                redirectErrorMsg = "Failed to calculate points";
            }
        }

        if (allSuccess) {
            // Redirect back to stage list with success message
            response.sendRedirect("stageList.jsp?msg=success");
        } else {
            // Redirect back to update form with error and optional message
            String errParam = "&error=update_failed";
            if (redirectErrorMsg != null) {
                try {
                    errParam += "&errorMsg=" + URLEncoder.encode(redirectErrorMsg, "UTF-8");
                } catch (Exception ex) {
                    // ignore encoding error and send without message
                }
            }
            response.sendRedirect("updateResult.jsp?stageId=" + stageId + errParam);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        try {
            String em = URLEncoder.encode(e.getMessage() != null ? e.getMessage() : "internal_error", "UTF-8");
            response.sendRedirect("updateResult.jsp?stageId=" + request.getParameter("stageId") + "&error=exception&errorMsg=" + em);
        } catch (Exception ex) {
            response.sendRedirect("updateResult.jsp?stageId=" + request.getParameter("stageId") + "&error=exception");
        }
    }
%>
