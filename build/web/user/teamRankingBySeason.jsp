<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team Rankings by Season</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String seasonIdParam = request.getParameter("seasonId");
            
            if (seasonIdParam == null || seasonIdParam.isEmpty()) {
                response.sendRedirect("teamRanking.jsp");
                return;
            }
            
            int seasonId = Integer.parseInt(seasonIdParam);
            
            SeasonDAO seasonDAO = new SeasonDAO();
            Season season = seasonDAO.getSeasonById(seasonId);
            
            if (season == null) {
        %>
                <div class="message info">
                    Season not found.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
        %>
        
        <h1>Team Rankings</h1>
        <h2>Season <%= season.getYear() %> - <%= season.getName() %></h2>
        
        <%
            TeamDAO teamDAO = new TeamDAO();
            List<Map<String, Object>> rankings = teamDAO.getTeamRankingsBySeason(seasonId);
            
            if (rankings != null && !rankings.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Team Name</th>
                        <th>Stages Participated</th>
                        <th>Points</th>
                        <th>Stage Wins</th>
                        <th>Status</th>
                        <th>Options</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map<String, Object> team : rankings) {
                            int rank = (Integer) team.get("rank");
                            String rowClass = "";
                            if (rank == 1) rowClass = "rank-1";
                            else if (rank == 2) rowClass = "rank-2";
                            else if (rank == 3) rowClass = "rank-3";
                    %>
                    <tr class="<%= rowClass %>">
                        <td><strong><%= rank %></strong></td>
                        <td><%= team.get("teamName") %></td>
                        <td><%= team.get("stagesParticipated") %></td>
                        <td><%= team.get("totalPoints") %></td>
                        <td><%= team.get("wins") %></td>
                        <td>
                            <span class="<%= (Boolean)team.get("status") ? "status-active" : "status-inactive" %>">
                                <%= (Boolean)team.get("status") ? "Active" : "Inactive" %>
                            </span>
                        </td>
                        <td>
                            <a href="teamDetail.jsp?teamId=<%= team.get("teamId") %>&seasonId=<%= seasonId %>" class="btn">
                                View Details
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
                No ranking data for this season.
            </div>
        <%
            }
        %>
        
        <div class="navigation">
            <a href="teamRanking.jsp" class="btn btn-secondary">Back to Rankings</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
