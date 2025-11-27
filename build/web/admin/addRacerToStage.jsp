<%-- 
    Document   : addRacerToStage
    Created on : Nov 27, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Racers to Stage</title>
        <link rel="stylesheet" href="../css/style.css">
        <style>
            .racer-checkbox {
                margin: 8px 0;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 4px;
            }
            .racer-checkbox:hover {
                background: #e9ecef;
            }
            .racer-checkbox input[type="checkbox"] {
                margin-right: 10px;
            }
            .section-title {
                margin-top: 20px;
                margin-bottom: 10px;
                font-size: 18px;
                font-weight: bold;
                color: #333;
            }
        </style>
        <script>
            function validateForm() {
                var checkboxes = document.querySelectorAll('input[name="racerIds"]:checked');
                
                if (checkboxes.length === 0) {
                    alert("Please select at least one racer!");
                    return false;
                }
                
                return confirm("Are you sure you want to add " + checkboxes.length + " racer(s) to this stage?");
            }
            
            function toggleSelectAll(source) {
                var checkboxes = document.querySelectorAll('input[name="racerIds"]');
                for (var i = 0; i < checkboxes.length; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }
        </script>
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?error=timeout");
                return;
            }
            
            String stageIdStr = request.getParameter("stageId");
            if (stageIdStr == null || stageIdStr.trim().isEmpty()) {
                response.sendRedirect("stageList.jsp");
                return;
            }
            
            int stageId = Integer.parseInt(stageIdStr);
            
            StageDAO stageDAO = new StageDAO();
            Stage stage = stageDAO.getStageInfo(stageId);
            
            if (stage == null) {
                response.sendRedirect("stageList.jsp");
                return;
            }
            
            RegisterDAO registerDAO = new RegisterDAO();
            List<Map<String, Object>> availableRacers = registerDAO.getAvailableRacers(stageId);
            List<Register> registeredRacers = registerDAO.getRegistersByStage(stageId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            String error = request.getParameter("error");
            String errorMsg = request.getParameter("errorMsg");
            String msg = request.getParameter("msg");
        %>
        
        <div class="container">
            <a href="stageList.jsp" class="back-button">← Back to Stage List</a>

            <h1>Add Racers to Stage</h1>
            
            <div class="stage-info">
                <p><strong>Stage Name:</strong> <%= stage.getName() %></p>
                <p><strong>Date:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></p>
                <p><strong>Location:</strong> <%= stage.getLocation() %></p>
                <p><strong>Total Laps:</strong> <%= stage.getTotalLaps() %></p>
            </div>
            
            <% if (msg != null && msg.equals("success")) { %>
                <div class="info-box" style="background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left-color: #28a745;">
                    Racers added successfully!
                </div>
            <% } %>
            
            <% if (error != null) { %>
                <div class="info-box" style="background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left-color: #dc3545;">
                    <%= errorMsg != null ? errorMsg : "Failed to add racers. Please try again." %>
                </div>
            <% } %>
            
            <% if (registeredRacers != null && !registeredRacers.isEmpty()) { %>
            <div class="section-title">Currently Registered Racers (<%= registeredRacers.size() %>)</div>
            <div style="background: #e7f3ff; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                <% for (Register reg : registeredRacers) { 
                    if (reg.getContract() != null && reg.getContract().getRacer() != null) {
                %>
                    <div style="display: inline-block; margin: 5px 10px; padding: 5px 10px; background: white; border-radius: 3px;">
                        <%= reg.getContract().getRacer().getName() %>
                        <% if (reg.getContract().getTeam() != null) { %>
                            (<%= reg.getContract().getTeam().getName() %>)
                        <% } %>
                    </div>
                <% 
                    }
                } %>
            </div>
            <% } %>
            
            <% if (availableRacers == null || availableRacers.isEmpty()) { %>
                <div class="card">
                    <p style="color: #6c757d;">No available racers to add. All active racers with contracts are already registered for this stage.</p>
                </div>
                <div class="button-group">
                    <a href="stageList.jsp" class="back-button">Back to Stage List</a>
                    <a href="updateResult.jsp?stageId=<%= stageId %>" class="btn-primary">Update Results</a>
                </div>
            <% } else { %>
            
            <div class="section-title">Available Racers (<%= availableRacers.size() %>)</div>
            
            <form action="doAddRacerToStage.jsp" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="stageId" value="<%= stageId %>">
                
                <div style="margin-bottom: 15px;">
                    <label>
                        <input type="checkbox" onclick="toggleSelectAll(this)"> Select All
                    </label>
                </div>
                
                <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; padding: 10px; border-radius: 4px;">
                    <% 
                    for (Map<String, Object> racer : availableRacers) {
                        int contractId = (Integer) racer.get("contractId");
                        String racerName = (String) racer.get("racerName");
                        String teamName = (String) racer.get("teamName");
                        String nationality = (String) racer.get("nationality");
                        Integer shirtNumber = (Integer) racer.get("shirtNumber");
                    %>
                    <div class="racer-checkbox">
                        <label>
                            <input type="checkbox" name="racerIds" value="<%= contractId %>">
                            <strong><%= racerName %></strong>
                            <% if (shirtNumber != null) { %>
                                (#<%= shirtNumber %>)
                            <% } %>
                            - <%= teamName %>
                            <% if (nationality != null) { %>
                                [<%= nationality %>]
                            <% } %>
                        </label>
                    </div>
                    <% } %>
                </div>
                
                <div class="form-actions" style="margin-top: 20px;">
                    <button type="submit" class="btn-primary">Add Selected Racers</button>
                    <a href="stageList.jsp" class="back-button">Cancel</a>
                </div>
            </form>
            
            <% } %>
        </div>
    </body>
</html>
