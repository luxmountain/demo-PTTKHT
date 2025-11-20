<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TeamDAO"%>
<%@page import="dao.StageDAO"%>
<%@page import="model.Stage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bảng xếp hạng đội đua theo chặng</title>
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
        .stage-info {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
            text-align: center;
        }
        .stage-info p {
            margin: 10px 0;
            font-size: 16px;
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
            String stageIdParam = request.getParameter("stageId");
            
            if (stageIdParam == null || stageIdParam.isEmpty()) {
                response.sendRedirect("stageSelection.jsp");
                return;
            }
            
            int stageId = Integer.parseInt(stageIdParam);
            
            StageDAO stageDAO = new StageDAO();
            Stage stage = stageDAO.getStageInfo(stageId);
            
            if (stage == null) {
        %>
                <div class="message info">
                    Không tìm thấy chặng đua.
                </div>
                <div class="navigation">
                    <a href="stageSelection.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
            
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
        %>
        
        <h1>Bảng xếp hạng đội đua theo chặng</h1>
        
        <div class="stage-info">
            <h2><%= stage.getName() %></h2>
            <p><strong>Địa điểm:</strong> <%= stage.getLocation() %></p>
            <p><strong>Ngày tổ chức:</strong> <%= stage.getDate() != null ? sdf.format(stage.getDate()) : "Chưa xác định" %></p>
            <% if (stage.getDescription() != null && !stage.getDescription().isEmpty()) { %>
                <p><strong>Mô tả:</strong> <%= stage.getDescription() %></p>
            <% } %>
        </div>
        
        <%
            TeamDAO teamDAO = new TeamDAO();
            List<Map<String, Object>> rankings = teamDAO.getTeamRankingsByStage(stageId);
            
            if (rankings != null && !rankings.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Thứ hạng</th>
                        <th>Tên đội đua</th>
                        <th>Quốc gia</th>
                        <th>Số tay đua tham gia</th>
                        <th>Vị trí cao nhất</th>
                        <th>Tổng điểm</th>
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
                        <td><%= team.get("nation") %></td>
                        <td><%= team.get("racersParticipated") %></td>
                        <td><%= team.get("bestPosition") != null ? team.get("bestPosition") : "N/A" %></td>
                        <td><%= team.get("totalPoints") %></td>
                        <td>
                            <span class="<%= (Boolean)team.get("status") ? "status-active" : "status-inactive" %>">
                                <%= (Boolean)team.get("status") ? "Đang hoạt động" : "Không hoạt động" %>
                            </span>
                        </td>
                        <td>
                            <a href="teamDetailByStage.jsp?teamId=<%= team.get("teamId") %>&stageId=<%= stageId %>" class="btn">
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
                Chưa có dữ liệu xếp hạng cho chặng đua này.
            </div>
        <%
            }
        %>
        
        <div class="navigation">
            <a href="stageSelection.jsp" class="btn btn-secondary">Quay lại chọn chặng đua</a>
            <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại bảng xếp hạng</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
