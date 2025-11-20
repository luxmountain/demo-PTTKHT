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
    <link rel="stylesheet" href="../css/style.css">
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
