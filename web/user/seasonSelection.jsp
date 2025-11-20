<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SeasonDAO"%>
<%@page import="model.Season"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chọn mùa giải</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .season-list {
            list-style: none;
            padding: 0;
            margin: 30px 0;
        }
        .season-list li {
            padding: 15px;
            margin: 10px 0;
            background: white;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .season-list li:hover {
            border-color: #007bff;
            background: #f0f8ff;
        }
        .season-list li a {
            text-decoration: none;
            color: #333;
            display: block;
            font-size: 18px;
            font-weight: bold;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
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
        .navigation {
            text-align: center;
            margin-top: 30px;
        }
    </style>
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
