<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Team"%>
<%@page import="model.Season"%>
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
            
            if (teamIdParam == null || seasonIdParam == null) {
                response.sendRedirect("teamRanking.jsp");
                return;
            }
            
            int teamId = Integer.parseInt(teamIdParam);
            int seasonId = Integer.parseInt(seasonIdParam);
            
            TeamDAO teamDAO = new TeamDAO();
            SeasonDAO seasonDAO = new SeasonDAO();
            
            Team team = teamDAO.getTeamById(teamId);
            Season season = seasonDAO.getSeasonById(seasonId);
            
            if (team == null || season == null) {
        %>
                <div class="message info">
                    Team or season information not found.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Back</a>
                </div>
        <%
                return;
            }
            
            Map<String, Object> teamStats = teamDAO.getTeamSeasonStats(teamId, seasonId);
            List<Map<String, Object>> racers = teamDAO.getRacersByTeam(teamId, seasonId);
            List<Map<String, Object>> performances = teamDAO.getTeamPerformanceByStage(teamId, seasonId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
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
                <div class="message info">
                    No racers in this team for the selected season.
                </div>
            <%
                }
            %>
        </div>

        <div class="section">
            <h3>Stage Performance</h3>
            <%
                if (performances != null && !performances.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Stage</th>
                            <th>Date</th>
                            <th>Best Position</th>
                            <th>Points</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Map<String, Object> perf : performances) {
                                Object bestPos = perf.get("bestPosition");
                        %>
                        <tr>
                            <td><%= perf.get("stageName") %></td>
                            <td><%= sdf.format(perf.get("stageDate")) %></td>
                            <td><%= bestPos != null ? bestPos : "Not participated" %></td>
                            <td><%= perf.get("totalPoints") %></td>
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
                    No stage performance data.
                </div>
            <%
                }
            %>
        </div>

        <div class="navigation">
            <a href="teamRankingBySeason.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Rankings</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
