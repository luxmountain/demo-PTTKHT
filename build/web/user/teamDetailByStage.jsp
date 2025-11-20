<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.StageDAO"%>
<%@page import="model.Team"%>
<%@page import="model.Stage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team Details - Stage</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String teamIdParam = request.getParameter("teamId");
            String stageIdParam = request.getParameter("stageId");
            
            if (teamIdParam == null || stageIdParam == null) {
                response.sendRedirect("stageSelection.jsp");
                return;
            }
            
            int teamId = Integer.parseInt(teamIdParam);
            int stageId = Integer.parseInt(stageIdParam);
            
            TeamDAO teamDAO = new TeamDAO();
            StageDAO stageDAO = new StageDAO();
            
            Team team = teamDAO.getTeamById(teamId);
            Stage stage = stageDAO.getStageInfo(stageId);
            
            if (team == null || stage == null) {
        %>
                <div class="message info">
                    Team or stage information not found.
                </div>
                <div class="navigation">
                    <a href="stageSelection.jsp" class="btn btn-secondary">Back</a>
                </div>
        <%
                return;
            }
            
            List<Map<String, Object>> racers = teamDAO.getTeamRacersInStage(teamId, stageId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH'h' mm'm' ss's'");
        %>
        
        <h1>Team Details - Stage</h1>
        
        <div class="info-section">
            <h2><%= team.getName() %></h2>
            <p><strong>Country:</strong> <%= team.getNation() %></p>
            <p><strong>Stage:</strong> <%= stage.getName() %></p>
            <p><strong>Location:</strong> <%= stage.getLocation() %></p>
            <p><strong>Date:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></p>
        </div>

        <div class="section">
            <h3>Riders and Results</h3>
            <%
                if (racers != null && !racers.isEmpty()) {
                    int totalPoints = 0;
                    Integer bestPosition = null;
                    
                    for (Map<String, Object> racer : racers) {
                        totalPoints += (Integer) racer.get("points");
                        int pos = (Integer) racer.get("position");
                        if (bestPosition == null || pos < bestPosition) {
                            bestPosition = pos;
                        }
                    }
            %>
                <div class="info-section">
                    <p><strong>Team total points:</strong> <%= totalPoints %> points</p>
                    <p><strong>Best position:</strong> <%= bestPosition %></p>
                    <p><strong>Number of participating riders:</strong> <%= racers.size() %></p>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Shirt No</th>
                            <th>Rider Name</th>
                            <th>Rank</th>
                            <th>Finish Time</th>
                            <th>Points</th>
                            <th>Options</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Map<String, Object> racer : racers) {
                                int position = (Integer) racer.get("position");
                                String rowClass = "";
                                if (position == 1) rowClass = "position-1";
                                else if (position == 2) rowClass = "position-2";
                                else if (position == 3) rowClass = "position-3";
                        %>
                        <tr class="<%= rowClass %>">
                            <td><%= racer.get("shirtNumber") %></td>
                            <td><%= racer.get("racerName") %></td>
                            <td><strong><%= position %></strong></td>
                            <td><%= racer.get("timeDone") != null ? sdfTime.format(racer.get("timeDone")) : "N/A" %></td>
                            <td><%= racer.get("points") %></td>
                            <td>
                                <a href="racerDetail.jsp?racerId=<%= racer.get("racerId") %>&seasonId=<%= stage.getSeasonId() %>" class="btn">
                                    View rider details
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                } else {
            %>
                <div class="message info">
                    This team has no riders in this stage.
                </div>
            <%
                }
            %>
        </div>

        <div class="navigation">
            <a href="teamRankingByStage.jsp?stageId=<%= stageId %>" class="btn btn-secondary">Back to Rankings</a>
            <a href="stageSelection.jsp" class="btn btn-secondary">Back to Stage Selection</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
