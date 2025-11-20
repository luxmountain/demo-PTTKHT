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
    <link rel="stylesheet" href="../css/style.css">
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
