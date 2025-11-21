<%-- 
    Document   : stageList
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách chặng đua</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?or=timeout");
                return;
            }

            String message = request.getParameter("msg");
            
            StageDAO stageDAO = new StageDAO();
            List<Stage> stages = stageDAO.getAllStages();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date today = new Date();
        %>
        
        <div class="container">
            <a href="adminHome.jsp" class="back-button">← Back to Dashboard</a>

            <h1>Stage List</h1>
            
            <% if (message != null && message.equals("success")) { %>
                <div class="info-box" style="background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left-color: #28a745;">
                    Results updated successfully!
                </div>
            <% } %>
            
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Stage Name</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Status</th>
                        <th>Total Laps</th>
                        <th>Options</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (stages != null && !stages.isEmpty()) {
                        for (int i = 0; i < stages.size(); i++) {
                            Stage stage = stages.get(i);
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
                    <tr>
                        <td><%= (i + 1) %></td>
                        <td><%= stage.getName() %></td>
                        <td><%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></td>
                        <td><%= stage.getLocation() %></td>
                        <td><span class="badge badge-<%= statusBadge %>"><%= statusText %></span></td>
                        <td><%= stage.getTotalLaps() %></td>
                        <td>
                            <a href="updateResult.jsp?stageId=<%= stage.getId() %>" class="btn-primary">Update Results</a>
                        </td>
                    </tr>
                    <% 
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center;">No stages available</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>
