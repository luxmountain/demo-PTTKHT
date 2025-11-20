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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #333;
            text-align: center;
        }
        .season-section {
            margin: 30px 0;
        }
        .season-header {
            background: #007bff;
            color: white;
            padding: 15px;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .stage-list {
            list-style: none;
            padding: 0;
        }
        .stage-list li {
            padding: 15px;
            margin: 10px 0;
            background: #f9f9f9;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .stage-list li:hover {
            border-color: #007bff;
            background: #f0f8ff;
        }
        .stage-list li a {
            text-decoration: none;
            color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .stage-name {
            font-weight: bold;
            font-size: 16px;
        }
        .stage-info {
            color: #666;
            font-size: 14px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .navigation {
            text-align: center;
            margin-top: 30px;
        }
        .message {
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
            text-align: center;
        }
        .info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
    </style>
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
