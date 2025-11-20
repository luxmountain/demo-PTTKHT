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
    <title>Chi tiết đội đua trong chặng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1, h2, h3 {
            color: #333;
        }
        .info-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .info-section p {
            margin: 10px 0;
            font-size: 16px;
        }
        .info-section strong {
            color: #007bff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .position-1 {
            background-color: #ffd700;
        }
        .position-2 {
            background-color: #c0c0c0;
        }
        .position-3 {
            background-color: #cd7f32;
        }
        .section {
            margin: 30px 0;
        }
        .btn {
            display: inline-block;
            padding: 8px 16px;
            margin: 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 14px;
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
                    Không tìm thấy thông tin đội đua hoặc chặng đua.
                </div>
                <div class="navigation">
                    <a href="stageSelection.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
            
            List<Map<String, Object>> racers = teamDAO.getTeamRacersInStage(teamId, stageId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH'h' mm'm' ss's'");
        %>
        
        <h1>Chi tiết đội đua trong chặng</h1>
        
        <div class="info-section">
            <h2><%= team.getName() %></h2>
            <p><strong>Quốc gia:</strong> <%= team.getNation() %></p>
            <p><strong>Chặng đua:</strong> <%= stage.getName() %></p>
            <p><strong>Địa điểm:</strong> <%= stage.getLocation() %></p>
            <p><strong>Ngày tổ chức:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "Chưa xác định" %></p>
        </div>

        <div class="section">
            <h3>Danh sách tay đua và kết quả</h3>
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
                    <p><strong>Tổng điểm của đội:</strong> <%= totalPoints %> điểm</p>
                    <p><strong>Vị trí cao nhất:</strong> <%= bestPosition %></p>
                    <p><strong>Số tay đua tham gia:</strong> <%= racers.size() %></p>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Số áo</th>
                            <th>Tên tay đua</th>
                            <th>Thứ hạng</th>
                            <th>Thời gian hoàn thành</th>
                            <th>Điểm</th>
                            <th>Tùy chọn</th>
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
                                    Xem chi tiết tay đua
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
                    Đội này không có tay đua nào tham gia chặng đua này.
                </div>
            <%
                }
            %>
        </div>

        <div class="navigation">
            <a href="teamRankingByStage.jsp?stageId=<%= stageId %>" class="btn btn-secondary">Quay lại bảng xếp hạng</a>
            <a href="stageSelection.jsp" class="btn btn-secondary">Quay lại chọn chặng đua</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
