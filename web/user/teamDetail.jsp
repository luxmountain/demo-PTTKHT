<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="dao.StageDAO"%>
<%@page import="model.Team"%>
<%@page import="model.Season"%>
<%@page import="model.Stage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team Details</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String teamIdParam = request.getParameter("teamId");
            String seasonIdParam = request.getParameter("seasonId");
            String stageIdParam = request.getParameter("stageId");

            if (teamIdParam == null || teamIdParam.isEmpty()) {
                response.sendRedirect("teamRanking.jsp");
                return;
            }

            int teamId = Integer.parseInt(teamIdParam);

            TeamDAO teamDAO = new TeamDAO();
            Team team = teamDAO.getTeamById(teamId);

            if (team == null) {
        %>
                <div class="message info">
                    Team information not found.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Back</a>
                </div>
        <%
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            if (seasonIdParam != null && !seasonIdParam.isEmpty()) {
                int seasonId = Integer.parseInt(seasonIdParam);
                SeasonDAO seasonDAO = new SeasonDAO();
                Season season = seasonDAO.getSeasonById(seasonId);

                if (season == null) {
        %>
                    <div class="message info">Season not found.</div>
                    <div class="navigation"><a href="teamRanking.jsp" class="btn btn-secondary">Back</a></div>
        <%
                    return;
                }

                Map<String, Object> teamStats = teamDAO.getTeamSeasonStats(teamId, seasonId);
                List<Map<String, Object>> racers = teamDAO.getRacersByTeam(teamId, seasonId);
                List<Map<String, Object>> performances = teamDAO.getTeamPerformanceByStage(teamId, seasonId);

        %>
                <h1>Team Details</h1>

                <div class="team-info">
                    <h2><%= team.getName() %></h2>
                    <p><strong>Country:</strong> <%= team.getNation() %></p>
                    <p><strong>Description:</strong> <%= team.getDescription() != null ? team.getDescription() : "No description" %></p>
                    <p><strong>Season:</strong> <%= season.getYear() %> - <%= season.getName() %></p>
                </div>

                <div class="stats-summary">
                    <div class="stat-box">
                        <div class="value"><%= teamStats.get("totalPoints") %></div>
                        <div class="label">Total Points</div>
                    </div>
                    <div class="stat-box">
                        <div class="value">
                            <%
                                Integer rank = (Integer) teamStats.get("rank");
                                if (rank != null && rank > 0) {
                                    out.print(rank);
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </div>
                        <div class="label">Current Rank</div>
                    </div>
                </div>

                <div class="section">
                    <h3>Racer List</h3>
                    <%
                        if (racers != null && !racers.isEmpty()) {
                    %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Shirt No</th>
                                    <th>Racer Name</th>
                                    <th>Nationality</th>
                                    <th>Options</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Map<String, Object> racer : racers) {
                                %>
                                <tr>
                                    <td><%= racer.get("shirtNumber") %></td>
                                    <td><%= racer.get("racerName") %></td>
                                    <td><%= racer.get("nationality") %></td>
                                    <td>
                                        <a href="racerDetail.jsp?racerId=<%= racer.get("racerId") %>&seasonId=<%= seasonId %>&teamId=<%= teamId %>" class="btn">
                                            View racer details
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
                        <div class="message info">No racers in this team for the selected season.</div>
                    <%
                        }
                    %>
                </div>

                <div class="navigation">
                    <a href="teamRanking.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Ranking</a>
                    <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
                </div>

        <%
            } else if (stageIdParam != null && !stageIdParam.isEmpty()) {
                int stageId = Integer.parseInt(stageIdParam);
                StageDAO stageDAO = new StageDAO();
                Stage stage = stageDAO.getStageInfo(stageId);

                if (stage == null) {
        %>
                    <div class="message info">Stage not found.</div>
                    <div class="navigation"><a href="stageSelection.jsp" class="btn btn-secondary">Back</a></div>
        <%
                    return;
                }

                List<Map<String, Object>> racers = teamDAO.getTeamRacersInStage(teamId, stageId);
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
                    <h3>Racers and Results</h3>
                    <%
                        if (racers != null && !racers.isEmpty()) {
                            int totalPoints = 0;
                            Integer bestPosition = null;
                            
                            for (Map<String, Object> racer : racers) {
                                Object ptsObj = racer.get("points");
                                if (ptsObj instanceof Number) totalPoints += ((Number)ptsObj).intValue();
                                Object posObj = racer.get("position");
                                if (posObj instanceof Number) {
                                    int pos = ((Number)posObj).intValue();
                                    if (bestPosition == null || pos < bestPosition) {
                                        bestPosition = pos;
                                    }
                                }
                            }
                    %>
                        <div class="info-section">
                            <p><strong>Team total points:</strong> <%= totalPoints %> points</p>
                            <p><strong>Best position:</strong> <%= bestPosition %></p>
                            <p><strong>Number of participating racers:</strong> <%= racers.size() %></p>
                        </div>
                        
                        <table>
                            <thead>
                                <tr>
                                    <th>Shirt No</th>
                                    <th>Racer Name</th>
                                    <th>Rank</th>
                                    <th>Finish Time</th>
                                    <th>Points</th>
                                    <th>Options</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Map<String, Object> racer : racers) {
                                        Object posObj = racer.get("position");
                                        int position = posObj instanceof Number ? ((Number)posObj).intValue() : 0;
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
                                        <a href="racerDetail.jsp?racerId=<%= racer.get("racerId") %>&seasonId=<%= stage.getSeasonId() %>" class="btn">View racer details</a>
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
                        <div class="message info">This team has no racers in this stage.</div>
                    <%
                        }
                    %>
                </div>

                <div class="navigation">
                    <a href="teamRanking.jsp?stageId=<%= stageId %>" class="btn btn-secondary">Back to Ranking</a>
                    <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
                </div>

        <%
            } else {
        %>
                <div class="message info">No seasonId or stageId provided. Choose a ranking to view.</div>
                <div class="navigation">
                    <a href="chooseTypeRanking.jsp" class="btn">Back</a>
                    <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>
