<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.RacerDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Racer Details</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String racerIdParam = request.getParameter("racerId");
            String seasonIdParam = request.getParameter("seasonId");
            String teamIdParam = request.getParameter("teamId");
            
            if (racerIdParam == null || seasonIdParam == null) {
                response.sendRedirect("teamRanking.jsp");
                return;
            }
            
            int racerId = Integer.parseInt(racerIdParam);
            int seasonId = Integer.parseInt(seasonIdParam);
            Integer teamId = teamIdParam != null ? Integer.parseInt(teamIdParam) : null;
            
            RacerDAO racerDAO = new RacerDAO();
            SeasonDAO seasonDAO = new SeasonDAO();
            
            Map<String, Object> racerDetails = racerDAO.getRacerDetails(racerId);
            Season season = seasonDAO.getSeasonById(seasonId);
            String teamName = racerDAO.getRacerTeamInSeason(racerId, seasonId);
            
            if (racerDetails == null || racerDetails.isEmpty() || season == null) {
        %>
                <div class="message info">
                    Racer or season information not found.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Back</a>
                </div>
        <%
                return;
            }
            
            Map<String, Object> racerStats = racerDAO.getRacerSeasonStats(racerId, seasonId);
            List<Map<String, Object>> performances = racerDAO.getRacerPerformanceByStage(racerId, seasonId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH'h' mm'm' ss's'");
        %>
        
        <h1>Racer Details</h1>
        
        <div class="racer-info">
            <h2><%= racerDetails.get("racerName") %></h2>
            <p><strong>Date of Birth:</strong> <%= racerDetails.get("dob") != null ? sdf.format(racerDetails.get("dob")) : "No information" %></p>
            <p><strong>Nationality:</strong> <%= racerDetails.get("nationality") %></p>
            <p><strong>Team:</strong> <%= teamName != null ? teamName : "No information" %></p>
            <p><strong>Shirt No:</strong> <%= racerDetails.get("shirtNumber") %></p>
            <p><strong>Season:</strong> <%= season.getYear() %> - <%= season.getName() %></p>
        </div>

        <div class="section">
            <h3>Season statistics</h3>
            <div class="stats-summary">
                <div class="stat-box">
                    <div class="value"><%= racerStats.get("stagesParticipated") %></div>
                    <div class="label">Total stages participated</div>
                </div>
                <div class="stat-box">
                    <div class="value"><%= racerStats.get("totalPoints") %></div>
                    <div class="label">Total Points</div>
                </div>
                <div class="stat-box">
                    <div class="value">
                        <%
                            Integer racerRank = (Integer) racerStats.get("rank");
                            if (racerRank != null && racerRank > 0) {
                                out.print(racerRank);
                            } else {
                                out.print("N/A");
                            }
                        %>
                    </div>
                    <div class="label">Individual rank in season</div>
                </div>
            </div>
        </div>

        <div class="section">
            <h3>Individual stage performances</h3>
            <%
                if (performances != null && !performances.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Stage</th>
                            <th>Date</th>
                            <th>Rank</th>
                            <th>Finish Time</th>
                            <th>Points</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Map<String, Object> perf : performances) {
                                int position = (Integer) perf.get("position");
                                String rowClass = "";
                                if (position == 1) rowClass = "position-1";
                                else if (position == 2) rowClass = "position-2";
                                else if (position == 3) rowClass = "position-3";
                        %>
                        <tr class="<%= rowClass %>">
                            <td><%= perf.get("stageName") %></td>
                            <td><%= sdf.format(perf.get("stageDate")) %></td>
                            <td><strong><%= position %></strong></td>
                            <td><%= perf.get("timeDone") != null ? sdfTime.format(perf.get("timeDone")) : "N/A" %></td>
                            <td><%= perf.get("points") %></td>
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
            <%
                if (teamId != null) {
            %>
                <a href="teamDetail.jsp?teamId=<%= teamId %>&seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Team</a>
            <%
                }
            %>
            <a href="teamRankingBySeason.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Rankings</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
