<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.RacerDAO"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết tay đua</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <%
            String racerIdParam = request.getParameter("racerId");
            String seasonIdParam = request.getParameter("seasonId");
            String teamIdParam = request.getParameter("teamId");
            
            if (racerIdParam == null || seasonIdParam == null) {
                response.sendRedirect("teamRanking.jsp");
                return;
            }
            
            int racerId = Integer.parseInt(racerIdParam);
            int seasonId = Integer.parseInt(seasonIdParam);
            Integer teamId = teamIdParam != null ? Integer.parseInt(teamIdParam) : null;
            
            RacerDAO racerDAO = new RacerDAO();
            SeasonDAO seasonDAO = new SeasonDAO();
            
            Map<String, Object> racerDetails = racerDAO.getRacerDetails(racerId);
            Season season = seasonDAO.getSeasonById(seasonId);
            String teamName = racerDAO.getRacerTeamInSeason(racerId, seasonId);
            
            if (racerDetails == null || racerDetails.isEmpty() || season == null) {
        %>
                <div class="message info">
                    Không tìm thấy thông tin tay đua hoặc mùa giải.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
        <%
                return;
            }
            
            Map<String, Object> racerStats = racerDAO.getRacerSeasonStats(racerId, seasonId);
            List<Map<String, Object>> performances = racerDAO.getRacerPerformanceByStage(racerId, seasonId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH'h' mm'm' ss's'");
        %>
        
        <h1>Chi tiết tay đua</h1>
        
        <div class="racer-info">
            <h2><%= racerDetails.get("racerName") %></h2>
            <p><strong>Ngày sinh:</strong> <%= racerDetails.get("dob") != null ? sdf.format(racerDetails.get("dob")) : "Không có thông tin" %></p>
            <p><strong>Quốc tịch:</strong> <%= racerDetails.get("nationality") %></p>
            <p><strong>Đội đua:</strong> <%= teamName != null ? teamName : "Không có thông tin" %></p>
            <p><strong>Số áo:</strong> <%= racerDetails.get("shirtNumber") %></p>
            <p><strong>Mùa giải:</strong> <%= season.getYear() %> - <%= season.getName() %></p>
        </div>

        <div class="section">
            <h3>Thống kê cá nhân trong mùa giải</h3>
            <div class="stats-summary">
                <div class="stat-box">
                    <div class="value"><%= racerStats.get("stagesParticipated") %></div>
                    <div class="label">Tổng số chặng tham gia</div>
                </div>
                <div class="stat-box">
                    <div class="value"><%= racerStats.get("totalPoints") %></div>
                    <div class="label">Tổng điểm tích lũy</div>
                </div>
                <div class="stat-box">
                    <div class="value">
                        <%
                            Integer racerRank = (Integer) racerStats.get("rank");
                            if (racerRank != null && racerRank > 0) {
                                out.print(racerRank);
                            } else {
                                out.print("N/A");
                            }
                        %>
                    </div>
                    <div class="label">Thứ hạng cá nhân trong mùa giải</div>
                </div>
            </div>
        </div>

        <div class="section">
            <h3>Thành tích cá nhân theo từng chặng</h3>
            <%
                if (performances != null && !performances.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Chặng đua</th>
                            <th>Ngày tổ chức</th>
                            <th>Thứ hạng</th>
                            <th>Thời gian hoàn thành</th>
                            <th>Điểm</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Map<String, Object> perf : performances) {
                                int position = (Integer) perf.get("position");
                                String rowClass = "";
                                if (position == 1) rowClass = "position-1";
                                else if (position == 2) rowClass = "position-2";
                                else if (position == 3) rowClass = "position-3";
                        %>
                        <tr class="<%= rowClass %>">
                            <td><%= perf.get("stageName") %></td>
                            <td><%= sdf.format(perf.get("stageDate")) %></td>
                            <td><strong><%= position %></strong></td>
                            <td><%= perf.get("timeDone") != null ? sdfTime.format(perf.get("timeDone")) : "N/A" %></td>
                            <td><%= perf.get("points") %></td>
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
            <%
                if (teamId != null) {
            %>
                <a href="teamDetail.jsp?teamId=<%= teamId %>&seasonId=<%= seasonId %>" class="btn btn-secondary">Quay lại đội đua</a>
            <%
                }
            %>
            <a href="teamRankingBySeason.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Quay lại bảng xếp hạng</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
