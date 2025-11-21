<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="dao.StageDAO"%>
<%@page import="model.Season"%>
<%@page import="model.Stage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team Rankings</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String seasonIdParam = request.getParameter("seasonId");
            String stageIdParam = request.getParameter("stageId");

            TeamDAO teamDAO = new TeamDAO();

            if ((seasonIdParam == null || seasonIdParam.isEmpty()) && (stageIdParam == null || stageIdParam.isEmpty())) {
        %>
                <h1>Team Rankings</h1>
                <div class="message info">
                    Vui lòng chọn một mùa hoặc một chặng để xem bảng xếp hạng.
                </div>
                <div class="navigation">
                    <a href="chooseSeason.jsp" class="btn">Chọn Mùa</a>
                    <a href="chooseRace.jsp" class="btn">Chọn Chặng</a>
                    <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
                </div>
        <%
                return;
            }

            if (seasonIdParam != null && !seasonIdParam.isEmpty()) {
                int seasonId = Integer.parseInt(seasonIdParam);
                SeasonDAO seasonDAO = new SeasonDAO();
                Season season = seasonDAO.getSeasonById(seasonId);

                if (season == null) {
        %>
                    <div class="message info">Season not found.</div>
                    <div class="navigation"><a href="chooseSeason.jsp" class="btn btn-secondary">Back</a></div>
        <%
                    return;
                }

        %>
                <h1>Team Rankings</h1>
                <h2>Season <%= season.getYear() %> - <%= season.getName() %></h2>

                <%
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
                                    <a href="teamDetail.jsp?teamId=<%= team.get("teamId") %>&seasonId=<%= seasonId %>" class="btn">View Details</a>
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
                    <div class="message info">No ranking data for this season.</div>
                <%
                    }
                %>

                <div class="navigation">
                    <a href="chooseSeason.jsp" class="btn btn-secondary">Back</a>
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
                    <div class="navigation"><a href="chooseRace.jsp" class="btn btn-secondary">Back</a></div>
        <%
                    return;
                }

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
        %>

                <h1>Team Rankings</h1>
                <div class="stage-info">
                    <h2><%= stage.getName() %></h2>
                    <p><strong>Location:</strong> <%= stage.getLocation() %></p>
                    <p><strong>Date:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "N/A" %></p>
                    <% if (stage.getDescription() != null && !stage.getDescription().isEmpty()) { %>
                        <p><strong>Description:</strong> <%= stage.getDescription() %></p>
                    <% } %>
                </div>

                <%
                    List<Map<String, Object>> rankings = teamDAO.getTeamRankingsByStage(stageId);
                    if (rankings != null && !rankings.isEmpty()) {
                %>
                    <table>
                        <thead>
                            <tr>
                                <th>Rank</th>
                                <th>Team Name</th>
                                <th>Country</th>
                                <th>Racers Participated</th>
                                <th>Best Position</th>
                                <th>Total Points</th>
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
                                <td><%= team.get("nation") %></td>
                                <td><%= team.get("racersParticipated") %></td>
                                <td><%= team.get("bestPosition") != null ? team.get("bestPosition") : "N/A" %></td>
                                <td><%= team.get("totalPoints") %></td>
                                <td>
                                    <span class="<%= (Boolean)team.get("status") ? "status-active" : "status-inactive" %>">
                                        <%= (Boolean)team.get("status") ? "Active" : "Inactive" %>
                                    </span>
                                </td>
                                <td>
                                    <a href="teamDetail.jsp?teamId=<%= team.get("teamId") %>&stageId=<%= stageId %>" class="btn">View Details</a>
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
                    <div class="message info">No ranking data for this stage.</div>
                <%
                    }
                %>

                <div class="navigation">
                    <a href="chooseRace.jsp" class="btn btn-secondary">Back</a>
                    <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
                </div>

        <%
            }
        %>
    </div>
</body>
</html>
