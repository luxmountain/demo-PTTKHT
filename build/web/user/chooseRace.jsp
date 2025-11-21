<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.StageDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Stage"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Select Stage</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Select a stage to view rankings</h1>
        
        <%
            SeasonDAO seasonDAO = new SeasonDAO();
            StageDAO stageDAO = new StageDAO();
            List<Season> seasons = seasonDAO.getAllSeasons();
            
            if (seasons != null && !seasons.isEmpty()) {
                for (Season season : seasons) {
        %>
                    <div class="season-section">
                        <div class="season-header">
                            Season <%= season.getYear() %> - <%= season.getName() %>
                        </div>
                        
                        <%
                                // Get stages for this season directly from DAO
                                List<Stage> stages = stageDAO.getStagesBySeason(season.getId());
                                if (stages != null && !stages.isEmpty()) {
                            %>
                                    <ul class="stage-list">
                            <%
                                    for (Stage stage : stages) {
                            %>
                                        <li>
                                            <a href="teamRanking.jsp?stageId=<%= stage.getId() %>">
                                                <div>
                                                    <div class="stage-name"><%= stage.getName() %></div>
                                                    <div class="stage-info">
                                                        <%= stage.getLocation() %> - 
                                                        <%= stage.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(stage.getDate()) : "No date" %>
                                                    </div>
                                                </div>
                                                <div>➜</div>
                                            </a>
                                        </li>
                            <%
                                    }
                            %>
                                    </ul>
                            <%
                                } else {
                            %>
                                    <div class="message info">
                                        No stages in this season.
                                    </div>
                            <%
                                }
                        %>
                    </div>
        <%
                }
            } else {
        %>
                <div class="message info">
                    No seasons found.
                </div>
        <%
            }
        %>

        <div class="navigation">
            <a href="chooseTypeRanking.jsp" class="btn btn-secondary">Back</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
