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
    <title>Racer Details</title>
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
                    Racer or season information not found.
                </div>
                <div class="navigation">
                    <a href="teamRanking.jsp" class="btn btn-secondary">Back</a>
                </div>
        <%
                return;
            }
            
            Map<String, Object> racerStats = racerDAO.getRacerSeasonStats(racerId, seasonId);
            List<Map<String, Object>> performances = racerDAO.getRacerPerformanceByStage(racerId, seasonId);
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH'h' mm'm' ss's'");
        %>
        
        <h1>Racer Details</h1>
        
        <div class="racer-info">
            <h2><%= racerDetails.get("racerName") %></h2>
            <p><strong>Date of Birth:</strong> <%= racerDetails.get("dob") != null ? sdf.format(racerDetails.get("dob")) : "No information" %></p>
            <p><strong>Nationality:</strong> <%= racerDetails.get("nationality") %></p>
            <p><strong>Team:</strong> <%= teamName != null ? teamName : "No information" %></p>
            <p><strong>Shirt No:</strong> <%= racerDetails.get("shirtNumber") %></p>
        </div>

        <div class="navigation">
            <%
                if (teamId != null) {
            %>
                <a href="teamDetail.jsp?teamId=<%= teamId %>&seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Team</a>
            <%
                }
            %>
            <a href="teamRanking.jsp?seasonId=<%= seasonId %>" class="btn btn-secondary">Back to Ranking</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
