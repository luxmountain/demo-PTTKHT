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
    <title>Bảng xếp hạng đội đua theo mùa giải</title>
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
        h1, h2 {
            color: #333;
            text-align: center;
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
        .rank-1 {
            background-color: #ffd700;
        }
        .rank-2 {
            background-color: #c0c0c0;
        }
        .rank-3 {
            background-color: #cd7f32;
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
        .status-active {
            color: green;
            font-weight: bold;
        }
        .status-inactive {
            color: red;
            font-weight: bold;
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
                    Không tìm thấy mùa giải.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
        %>
        
        <h1>Bảng xếp hạng đội đua</h1>
        <h2>Mùa giải <%= season.getYear() %> - <%= season.getName() %></h2>
        
        <%
            TeamDAO teamDAO = new TeamDAO();
            List<Map<String, Object>> rankings = teamDAO.getTeamRankingsBySeason(seasonId);
            
            if (rankings != null && !rankings.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Thứ hạng</th>
                        <th>Tên đội đua</th>
                        <th>Số chặng tham gia</th>
                        <th>Số điểm</th>
                        <th>Số lần thắng chặng</th>
                        <th>Trạng thái</th>
                        <th>Tùy chọn</th>
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
                                <%= (Boolean)team.get("status") ? "Đang thi đấu" : "Không hoạt động" %>
                            </span>
                        </td>
                        <td>
                            <a href="teamDetail.jsp?teamId=<%= team.get("teamId") %>&seasonId=<%= seasonId %>" class="btn">
                                Xem chi tiết
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
                Chưa có dữ liệu xếp hạng cho mùa giải này.
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
