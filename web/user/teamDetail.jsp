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
    <title>Chi tiết đội đua</title>
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
        .team-info {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .team-info p {
            margin: 10px 0;
            font-size: 16px;
        }
        .team-info strong {
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
        .stats-summary {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }
        .stat-box {
            text-align: center;
            padding: 20px;
            background: #e7f3ff;
            border-radius: 5px;
            flex: 1;
            margin: 0 10px;
        }
        .stat-box .value {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        }
        .stat-box .label {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
    </style>
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
                    Không tìm thấy thông tin đội đua hoặc mùa giải.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
            
            Map<String, Object> teamStats = teamDAO.getTeamSeasonStats(teamId, seasonId);
            List<Map<String, Object>> racers = teamDAO.getRacersByTeam(teamId, seasonId);
            List<Map<String, Object>> performances = teamDAO.getTeamPerformanceByStage(teamId, seasonId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        %>
        
        <h1>Chi tiết đội đua</h1>
        
        <div class="team-info">
            <h2><%= team.getName() %></h2>
            <p><strong>Quốc gia:</strong> <%= team.getNation() %></p>
            <p><strong>Mô tả:</strong> <%= team.getDescription() != null ? team.getDescription() : "Không có mô tả" %></p>
            <p><strong>Mùa giải:</strong> <%= season.getYear() %> - <%= season.getName() %></p>
        </div>

        <div class="stats-summary">
            <div class="stat-box">
                <div class="value"><%= teamStats.get("totalPoints") %></div>
                <div class="label">Tổng điểm tích lũy</div>
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
                <div class="label">Thứ hạng hiện tại</div>
            </div>
        </div>

        <div class="section">
            <h3>Danh sách tay đua</h3>
            <%
                if (racers != null && !racers.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Số áo</th>
                            <th>Tên tay đua</th>
                            <th>Quốc tịch</th>
                            <th>Tùy chọn</th>
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
                    Không có tay đua nào trong đội này cho mùa giải được chọn.
                </div>
            <%
                }
            %>
        </div>

        <div class="section">
            <h3>Thành tích theo từng chặng</h3>
            <%
                if (performances != null && !performances.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Chặng đua</th>
                            <th>Ngày tổ chức</th>
                            <th>Vị trí cao nhất</th>
                            <th>Điểm</th>
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
                            <td><%= bestPos != null ? bestPos : "Chưa tham gia" %></td>
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
                    Không có dữ liệu thành tích theo chặng.
                </div>
            <%
                }
            %>
        </div>

        <div class="navigation">
            <a href="teamRankingBySeason.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Quay lại bảng xếp hạng</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
