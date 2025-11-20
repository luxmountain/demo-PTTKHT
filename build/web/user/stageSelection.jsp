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
    <title>Chọn chặng đua</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Chọn chặng đua để xem bảng xếp hạng</h1>
        
        <%
            SeasonDAO seasonDAO = new SeasonDAO();
            StageDAO stageDAO = new StageDAO();
            List<Season> seasons = seasonDAO.getAllSeasons();
            
            if (seasons != null && !seasons.isEmpty()) {
                for (Season season : seasons) {
        %>
                    <div class="season-section">
                        <div class="season-header">
                            Mùa giải <%= season.getYear() %> - <%= season.getName() %>
                        </div>
                        
                        <%
                            // Get stages for this season
                            List<Stage> stages = stageDAO.getAllStages();
                            boolean hasStages = false;
                            
                            for (Stage stage : stages) {
                                if (stage.getSeasonId() == season.getId()) {
                                    if (!hasStages) {
                                        hasStages = true;
                        %>
                                        <ul class="stage-list">
                        <%
                                    }
                        %>
                                    <li>
                                        <a href="teamRankingByStage.jsp?stageId=<%= stage.getId() %>">
                                            <div>
                                                <div class="stage-name"><%= stage.getName() %></div>
                                                <div class="stage-info">
                                                    <%= stage.getLocation() %> - 
                                                    <%= stage.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(stage.getDate()) : "Chưa có ngày" %>
                                                </div>
                                            </div>
                                            <div>➜</div>
                                        </a>
                                    </li>
                        <%
                                }
                            }
                            
                            if (hasStages) {
                        %>
                                        </ul>
                        <%
                            } else {
                        %>
                                <div class="message info">
                                    Không có chặng đua nào trong mùa giải này.
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
                    Không có mùa giải nào được tìm thấy.
                </div>
        <%
            }
        %>

        <div class="navigation">
            <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại bảng xếp hạng</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
