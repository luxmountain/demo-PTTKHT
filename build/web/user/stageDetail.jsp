<%-- 
    Document   : stageDetail
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.text.*, java.util.*, dao.*, model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stage Detail</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?error=timeout");
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
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

            // Load registers & results for this stage
            RegisterDAO registerDAO = new RegisterDAO();
            List<Register> registers = registerDAO.getRegistersByStage(stageId);
        %>

        <div class="container">
            <%
                if (stage == null) {
            %>
            <div class="card">
                <h3>Race Not Found</h3>
                <p>The requested race (ID: <%= stageId%>) could not be found.</p>
            </div>
            <%
            } else {
            %>
            <h1>Detail Race</h1>

            <div class="card">
                <h2><%= stage.getName()%></h2>

                <div class="detail-section">
                    <div class="detail-row">
                        <span class="detail-label">Race name:</span>
                        <span class="detail-value"><%= stage.getName()%></span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Date:</span>
                        <span class="detail-value">
                            <%= stage.getDate() != null ? dateFormat.format(stage.getDate()) : "N/A"%>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Location:</span>
                        <span class="detail-value">
                            <%= stage.getLocation() != null ? stage.getLocation() : "N/A"%>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value">
                            <%= stage.isStatus() ? "Active" : "Inactive"%>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Total Laps:</span>
                        <span class="detail-value">
                            <%= stage.getTotalLaps()%>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Description:</span>
                        <span class="detail-value">
                            <%= stage.getDescription() != null ? stage.getDescription() : "N/A"%>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Number of drivers:</span>
                        <span class="detail-value"><%= registers != null ? registers.size() : 0%></span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Route:</span>
                        <span class="detail-value">
                            <%= stage.getRoadmap() != null ? stage.getRoadmap() : "N/A"%>
                        </span>
                    </div>
                </div>
            </div>

            <h2>Result</h2>

            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Driver Name</th>
                        <th>Team</th>
                        <th>Laps</th>
                        <th>Finish Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (registers == null || registers.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="4" style="text-align: center; color: #999;">No results available</td>
                    </tr>
                    <%
                    } else {
                        for (int i = 0; i < registers.size(); i++) {
                            Register reg = registers.get(i);
                            Result r = reg.getResult();
                            int laps = (r != null) ? r.getLapsCompleted() : 0;
                            int totalLapsForStage = (stage != null) ? stage.getTotalLaps() : 0;
                    %>
                    <tr>
                        <td><%= (i + 1)%></td>
                        <td><%= (reg.getContract() != null && reg.getContract().getRacer() != null) ? reg.getContract().getRacer().getName() : "N/A"%></td>
                        <td><%= (reg.getContract() != null && reg.getContract().getTeam() != null) ? reg.getContract().getTeam().getName() : "N/A"%></td>
                        <td><%= laps %></td>
                        <td><%= (r == null ? "N/A" : (laps < totalLapsForStage ? "DNF" : (r.getTimedone() != null ? timeFormat.format(r.getTimedone()) : "N/A"))) %></td>
                    </tr>
                    <%
                            }
                        }
                    %>
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
