<%-- 
    Document   : updateResult
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Stage Results</title>
        <link rel="stylesheet" href="../css/style.css">
        <script>
            function validateForm() {
                var inputs = document.querySelectorAll('input[type="number"], input[type="time"]');
                var hasData = false;
                
                for (var i = 0; i < inputs.length; i++) {
                    if (inputs[i].value !== '') {
                        hasData = true;
                        break;
                    }
                }
                
                if (!hasData) {
                    alert('Please enter at least one result!');
                    return false;
                }
                
                // Validate that if position is entered, time should also be entered
                var rows = document.querySelectorAll('tbody tr');
                for (var i = 0; i < rows.length; i++) {
                    var position = rows[i].querySelector('input[name^="position"]').value;
                    var time = rows[i].querySelector('input[name^="time"]').value;
                    
                    if (position !== '' && time === '') {
                        alert('Please enter finish time for the rider with position ' + position);
                        return false;
                    }
                }
                
                return confirm('Are you sure you want to save these results?');
            }
        </script>
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?err=timeout");
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
            
            ResultDAO resultDAO = new ResultDAO();
            List<Register> registers = resultDAO.getRegistersByStage(stageId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date today = new Date();
            
            String statusText = "";
            String statusBadge = "";
            
            if (stage.getDate() != null) {
                if (stage.getDate().before(today)) {
                    statusText = "Completed";
                    statusBadge = "completed";
                } else {
                    statusText = "Upcoming";
                    statusBadge = "upcoming";
                }
            } else {
                statusText = "Unknown";
                statusBadge = "upcoming";
            }
        %>
        
        <div class="container">
            <a href="stageList.jsp" class="back-button">← Back to Stage List</a>

            <h1>Update Stage Results</h1>
            
            <div class="stage-info">
                <p><strong>Stage Name:</strong> <%= stage.getName() %></p>
                <p><strong>Date:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></p>
                <p><strong>Location:</strong> <%= stage.getLocation() %></p>
                <p><strong>Status:</strong> <span class="badge badge-<%= statusBadge %>"><%= statusText %></span></p>
            </div>
            
            <% if (registers == null || registers.isEmpty()) { %>
                <div class="card">
                    <p style="color: #dc3545;">No riders registered for this stage.</p>
                </div>
                <div class="button-group">
                    <a href="stageList.jsp" class="back-button">Back</a>
                </div>
            <% } else { %>
            
            <form action="doUpdateResult.jsp" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="stageId" value="<%= stageId %>">
                
                <table>
                    <thead>
                        <tr>
                            <th>Rider Name</th>
                            <th>Team</th>
                            <th>Position</th>
                            <th>Finish Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        for (int i = 0; i < registers.size(); i++) {
                            Register register = registers.get(i);
                            Result result = register.getResult();
                            String timeValue = "";
                            if (result != null && result.getTimedone() != null) {
                                timeValue = result.getTimedone().toString();
                            }
                            Integer position = (result != null) ? result.getPosition() : null;
                        %>
                        <tr>
                            <td>
                                <%= register.getRacerName() %>
                                <input type="hidden" name="registerId_<%= i %>" value="<%= register.getId() %>">
                            </td>
                            <td><%= register.getTeamName() %></td>
                            <td>
                                <input type="number" 
                                       name="position_<%= i %>" 
                                       min="1" 
                                       value="<%= position != null ? position : "" %>"
                                       placeholder="Enter position">
                            </td>
                            <td>
                                <input type="time" 
                                       name="time_<%= i %>" 
                                       step="1"
                                       value="<%= timeValue %>"
                                       placeholder="HH:MM:SS">
                            </td>
                        </tr>
                        <% } %>
                        <input type="hidden" name="racerCount" value="<%= registers.size() %>">
                    </tbody>
                </table>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Save results</button>
                    <a href="stageList.jsp" class="back-button">Cancel</a>
                </div>
            </form>
            
            <% } %>
        </div>
    </body>
</html>
