<%-- 
    Document   : stageDetail
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.text.*, dao.*, model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stage Detail</title>
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?err=timeout");
                return;
            }

            String stageIdParam = request.getParameter("id");
            
            if (stageIdParam == null || stageIdParam.trim().isEmpty()) {
                response.sendRedirect("searchStage.jsp?error=invalid");
                return;
            }

            int stageId = 0;
            try {
                stageId = Integer.parseInt(stageIdParam);
            } catch (NumberFormatException e) {
                response.sendRedirect("searchStage.jsp?error=invalid");
                return;
            }

            StageDAO stageDAO = new StageDAO();
            Stage stage = stageDAO.getStageInfo(stageId);
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        %>
        
        <div class="container">
            <%
                if (stage == null) {
            %>
                <div class="error-message">
                    <h3>Race Not Found</h3>
                    <p>The requested race (ID: <%= stageId %>) could not be found.</p>
                </div>
            <%
                } else {
            %>
                <h2>Detail Race</h2>
                
                <div class="detail-section">
                    <div class="detail-row">
                        <span class="detail-label">Race name:</span>
                        <span class="detail-value"><%= stage.getName() %></span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Date:</span>
                        <span class="detail-value">
                            <%= stage.getDate() != null ? dateFormat.format(stage.getDate()) : "N/A" %>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Location:</span>
                        <span class="detail-value">
                            <%= stage.getLocation() != null ? stage.getLocation() : "N/A" %>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value">
                            <%= stage.isStatus() ? "Active" : "Inactive" %>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Description:</span>
                        <span class="detail-value">
                            <%= stage.getDescription() != null ? stage.getDescription() : "N/A" %>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Number of drivers:</span>
                        <span class="detail-value">0</span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Route:</span>
                        <span class="detail-value">
                            <%= stage.getRoadmap() != null ? stage.getRoadmap() : "N/A" %>
                        </span>
                    </div>
                </div>
                
                <h3>Result</h3>
                
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Driver Name</th>
                            <th>Team</th>
                            <th>Finish Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="4" style="text-align: center; color: #999;">No results available</td>
                        </tr>
                    </tbody>
                </table>
            <%
                }
            %>
            
            <div class="button-group">
                <a href="stageListSearch.jsp" class="back-button">Back</a>
            </div>
        </div>
    </body>
</html>
