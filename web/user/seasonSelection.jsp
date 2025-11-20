<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chọn mùa giải</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Chọn mùa giải</h1>
        
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
                    <a href="teamRankingBySeason.jsp?seasonId=<%= season.getId() %>">
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
                Không có mùa giải nào được tìm thấy.
            </div>
        <%
            }
        %>

        <div class="navigation">
            <a href="teamRanking.jsp" class="btn btn-secondary">Quay lại</a>
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
        </div>
    </div>
</body>
</html>
