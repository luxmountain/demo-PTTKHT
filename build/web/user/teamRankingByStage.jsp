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
    <link rel="stylesheet" href="../css/style.css">
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
