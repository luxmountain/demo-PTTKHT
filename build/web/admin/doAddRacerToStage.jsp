<%-- 
    Document   : doAddRacerToStage
    Created on : Nov 27, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*" %>
<%
    Member admin = (Member) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../login.jsp?error=timeout");
        return;
    }

    try {
        String stageIdStr = request.getParameter("stageId");
        String[] racerIdsStr = request.getParameterValues("racerIds");
        
        if (stageIdStr == null || stageIdStr.trim().isEmpty()) {
            response.sendRedirect("stageList.jsp");
            return;
        }
        
        if (racerIdsStr == null || racerIdsStr.length == 0) {
            response.sendRedirect("addRacerToStage.jsp?stageId=" + stageIdStr + "&error=true&errorMsg=Please select at least one racer!");
            return;
        }
        
        int stageId = Integer.parseInt(stageIdStr);
        RegisterDAO registerDAO = new RegisterDAO();
        
        int successCount = 0;
        int failCount = 0;
        
        // Add each selected racer to the stage
        for (String racerIdStr : racerIdsStr) {
            try {
                int contractId = Integer.parseInt(racerIdStr);
                
                // Create Register object
                Register register = new Register();
                Contract contract = new Contract();
                contract.setId(contractId);
                register.setContract(contract);
                Stage stage = new Stage();
                stage.setId(stageId);
                register.setStage(stage);
                register.setDateRegistered(new java.sql.Date(System.currentTimeMillis()));
                register.setStatus(true);
                
                boolean success = registerDAO.addRegister(register);
                
                if (success) {
                    successCount++;
                } else {
                    failCount++;
                }
            } catch (Exception e) {
                e.printStackTrace();
                failCount++;
            }
        }
        
        if (successCount > 0 && failCount == 0) {
            response.sendRedirect("addRacerToStage.jsp?stageId=" + stageId + "&msg=success");
        } else if (successCount > 0 && failCount > 0) {
            response.sendRedirect("addRacerToStage.jsp?stageId=" + stageId + "&error=true&errorMsg=" + successCount + " racer(s) added successfully, but " + failCount + " failed!");
        } else {
            response.sendRedirect("addRacerToStage.jsp?stageId=" + stageId + "&error=true&errorMsg=Failed to add racers. Please try again!");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        String stageId = request.getParameter("stageId");
        response.sendRedirect("addRacerToStage.jsp?stageId=" + stageId + "&error=true&errorMsg=" + e.getMessage());
    }
%>
