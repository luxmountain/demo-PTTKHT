<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="dao.StageDAO"%>
<%@page import="model.Season"%>
<%@page import="model.Stage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>

<%!
    // Helper method: Get CSS class for rank
    private String getRankClass(int rank) {
        if (rank == 1) return "rank-1";
        if (rank == 2) return "rank-2";
        if (rank == 3) return "rank-3";
        return "";
    }
    
    // Helper method: Render status badge
    private String renderStatusBadge(boolean status) {
        String cssClass = status ? "status-active" : "status-inactive";
        String label = status ? "Active" : "Inactive";
        return String.format("<span class=\"%s\">%s</span>", cssClass, label);
    }
    
    // Helper method: Format value or N/A
    private String formatValue(Object value) {
        return value != null ? value.toString() : "N/A";
    }
%>

<%
    // === LOGIC LAYER: Process request parameters ===
    String seasonIdParam = request.getParameter("seasonId");
    String stageIdParam = request.getParameter("stageId");
    
    TeamDAO teamDAO = new TeamDAO();
    
    // Determine ranking type
    boolean isSeason = seasonIdParam != null && !seasonIdParam.isEmpty();
    boolean isStage = stageIdParam != null && !stageIdParam.isEmpty();
    boolean noSelection = !isSeason && !isStage;
    
    // Prepare data variables
    String pageTitle = "Team Rankings";
    String subtitle = "";
    List<Map<String, Object>> rankings = null;
    String backUrl = "";
    String detailUrlParam = "";
    
    // Process based on type
    if (isSeason) {
        int seasonId = Integer.parseInt(seasonIdParam);
        SeasonDAO seasonDAO = new SeasonDAO();
        Season season = seasonDAO.getSeasonById(seasonId);
        
        if (season != null) {
            subtitle = "Season " + season.getYear() + " - " + season.getName();
            rankings = teamDAO.getTeamRankingsBySeason(seasonId);
            backUrl = "chooseSeason.jsp";
            detailUrlParam = "seasonId=" + seasonId;
        }
    } else if (isStage) {
        int stageId = Integer.parseInt(stageIdParam);
        StageDAO stageDAO = new StageDAO();
        Stage stage = stageDAO.getStageInfo(stageId);
        
        if (stage != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            subtitle = stage.getName();
            rankings = teamDAO.getTeamRankingsByStage(stageId);
            backUrl = "chooseRace.jsp";
            detailUrlParam = "stageId=" + stageId;
            
            // Store stage info for display
            request.setAttribute("stageInfo", stage);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <% if (noSelection) { %>
            <!-- No selection made -->
            <h1><%= pageTitle %></h1>
            <div class="message info">
                Vui lòng chọn một mùa hoặc một chặng để xem bảng xếp hạng.
            </div>
            <div class="navigation">
                <a href="chooseSeason.jsp" class="btn">Chọn Mùa</a>
                <a href="chooseRace.jsp" class="btn">Chọn Chặng</a>
                <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
            
        <% } else if (rankings == null) { %>
            <!-- Data not found -->
            <div class="message info"><%= isSeason ? "Season" : "Stage" %> not found.</div>
            <div class="navigation">
                <a href="<%= backUrl %>" class="btn btn-secondary">Back</a>
            </div>
            
        <% } else { %>
            <!-- Display rankings -->
            <h1><%= pageTitle %></h1>
            
            <% if (isStage) { 
                Stage stageInfo = (Stage) request.getAttribute("stageInfo");
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            %>
                <div class="stage-info">
                    <h2><%= stageInfo.getName() %></h2>
                    <p><strong>Location:</strong> <%= stageInfo.getLocation() %></p>
                    <p><strong>Date:</strong> <%= stageInfo.getDate() != null ? sdf.format(stageInfo.getDate()) : "N/A" %></p>
                    <% if (stageInfo.getDescription() != null && !stageInfo.getDescription().isEmpty()) { %>
                        <p><strong>Description:</strong> <%= stageInfo.getDescription() %></p>
                    <% } %>
                </div>
            <% } else { %>
                <h2><%= subtitle %></h2>
            <% } %>
            
            <% if (rankings != null && !rankings.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Team Name</th>
                            <% if (isSeason) { %>
                                <th>Stages Participated</th>
                                <th>Points</th>
                                <th>Stage Wins</th>
                            <% } else { %>
                                <th>Country</th>
                                <th>Racers Participated</th>
                                <th>Best Position</th>
                                <th>Total Points</th>
                            <% } %>
                            <th>Status</th>
                            <th>Options</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> team : rankings) {
                            int rank = (Integer) team.get("rank");
                            String rowClass = getRankClass(rank);
                        %>
                        <tr class="<%= rowClass %>">
                            <td><strong><%= rank %></strong></td>
                            <td><%= team.get("teamName") %></td>
                            <% if (isSeason) { %>
                                <td><%= team.get("stagesParticipated") %></td>
                                <td><%= team.get("totalPoints") %></td>
                                <td><%= team.get("wins") %></td>
                            <% } else { %>
                                <td><%= team.get("nation") %></td>
                                <td><%= team.get("racersParticipated") %></td>
                                <td><%= formatValue(team.get("bestPosition")) %></td>
                                <td><%= team.get("totalPoints") %></td>
                            <% } %>
                            <td><%= renderStatusBadge((Boolean) team.get("status")) %></td>
                            <td>
                                <a href="teamDetail.jsp?teamId=<%= team.get("teamId") %>&<%= detailUrlParam %>" class="btn">View Details</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="message info">No ranking data for this <%= isSeason ? "season" : "stage" %>.</div>
            <% } %>
            
            <div class="navigation">
                <a href="<%= backUrl %>" class="btn btn-secondary">Back</a>
                <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        <% } %>
    </div>
</body>
</html>
