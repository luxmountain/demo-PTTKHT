<%-- 
    Document   : stageListSearch
    Created on : Nov 20, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*, java.text.*, model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Results - Stages</title>
    </head>
    <body>
        <%
            Member user = (Member) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("../login.jsp?err=timeout");
                return;
            }

            @SuppressWarnings("unchecked")
            List<Stage> stages = (List<Stage>) session.getAttribute("searchResults");
            String keyword = (String) session.getAttribute("searchKeyword");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        %>
        
        <div class="container">
            <h2>Search Race Result</h2>
            
            <div class="search-info">
                Result with keyword "<%= keyword %>" | Total: <%= stages != null ? stages.size() : 0 %>
            </div>
            
            <button class="tab-button">Stage List</button>
            
            <%
                if (stages == null || stages.isEmpty()) {
            %>
                <div class="no-results">
                    <p>No races found matching your search keyword.</p>
                </div>
            <%
                } else {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Race Name</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Option</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int no = 1;
                            for (Stage stage : stages) {
                                String formattedDate = stage.getDate() != null 
                                    ? dateFormat.format(stage.getDate()) 
                                    : "N/A";
                        %>
                        <tr>
                            <td><%= no++ %></td>
                            <td><%= stage.getName() %></td>
                            <td><%= formattedDate %></td>
                            <td><%= stage.getLocation() != null ? stage.getLocation() : "N/A" %></td>
                            <td><%= stage.isStatus() ? "Active" : "Inactive" %></td>
                            <td>
                                <a href="stageDetail.jsp?id=<%= stage.getId() %>" class="view-detail-btn">View Detail</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                }
            %>
        </div>
    </body>
</html>
