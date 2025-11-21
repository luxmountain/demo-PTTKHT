<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Select Season</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Select Season</h1>
        
        <%
            SeasonDAO seasonDAO = new SeasonDAO();
            List<Season> seasons = seasonDAO.getAllSeasons();
            
            if (seasons != null && !seasons.isEmpty()) {
        %>
            <ul class="season-list">
                <%
                    for (Season season : seasons) {
                %>
                <li>
                    <a href="teamRanking.jsp?seasonId=<%= season.getId() %>">
                        <%= season.getYear() %> - <%= season.getName() %>
                    </a>
                </li>
                <%
                    }
                %>
            </ul>
        <%
            } else {
        %>
            <div class="message info">
                No seasons found.
            </div>
        <%
            }
        %>

        <div class="navigation">
            <a href="chooseTypeRanking.jsp" class="btn btn-secondary">Back</a>
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
