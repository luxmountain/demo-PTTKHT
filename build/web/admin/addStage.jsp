<%-- 
    Document   : addStage
    Created on : Nov 27, 2025
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,dao.*,java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Stage</title>
        <link rel="stylesheet" href="../css/style.css">
        <script>
            function validateForm() {
                var name = document.forms["addStageForm"]["name"].value.trim();
                var date = document.forms["addStageForm"]["date"].value;
                var location = document.forms["addStageForm"]["location"].value.trim();
                var totalLaps = document.forms["addStageForm"]["totalLaps"].value;
                var seasonId = document.forms["addStageForm"]["seasonId"].value;
                
                if (name === "") {
                    alert("Please enter stage name!");
                    return false;
                }
                
                if (date === "") {
                    alert("Please select stage date!");
                    return false;
                }
                
                if (location === "") {
                    alert("Please enter location!");
                    return false;
                }
                
                if (totalLaps === "" || parseInt(totalLaps) <= 0) {
                    alert("Please enter valid total laps (greater than 0)!");
                    return false;
                }
                
                if (seasonId === "") {
                    alert("Please select a season!");
                    return false;
                }
                
                return confirm("Are you sure you want to add this stage?");
            }
        </script>
    </head>
    <body>
        <%
            Member admin = (Member) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect("../login.jsp?error=timeout");
                return;
            }
            
            SeasonDAO seasonDAO = new SeasonDAO();
            List<Season> seasons = seasonDAO.getAllSeasons();
            
            String error = request.getParameter("error");
            String errorMsg = request.getParameter("errorMsg");
        %>
        
        <div class="container">
            <a href="stageList.jsp" class="back-button">← Back to Stage List</a>

            <h1>Add New Stage</h1>
            
            <% if (error != null) { %>
                <div class="info-box" style="background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left-color: #dc3545;">
                    <%= errorMsg != null ? errorMsg : "Failed to add stage. Please try again." %>
                </div>
            <% } %>
            
            <form name="addStageForm" action="doAddStage.jsp" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="name">Stage Name: <span style="color: red;">*</span></label>
                    <input type="text" 
                           id="name" 
                           name="name" 
                           class="form-control" 
                           placeholder="Enter stage name"
                           maxlength="255">
                </div>
                
                <div class="form-group">
                    <label for="date">Date: <span style="color: red;">*</span></label>
                    <input type="date" 
                           id="date" 
                           name="date" 
                           class="form-control">
                </div>
                
                <div class="form-group">
                    <label for="location">Location: <span style="color: red;">*</span></label>
                    <input type="text" 
                           id="location" 
                           name="location" 
                           class="form-control" 
                           placeholder="Enter location"
                           maxlength="255">
                </div>
                
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" 
                              name="description" 
                              class="form-control" 
                              rows="3" 
                              placeholder="Enter description (optional)"
                              maxlength="255"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="roadmap">Roadmap:</label>
                    <input type="text" 
                           id="roadmap" 
                           name="roadmap" 
                           class="form-control" 
                           placeholder="Enter roadmap (optional)"
                           maxlength="255">
                </div>
                
                <div class="form-group">
                    <label for="totalLaps">Total Laps: <span style="color: red;">*</span></label>
                    <input type="number" 
                           id="totalLaps" 
                           name="totalLaps" 
                           class="form-control" 
                           placeholder="Enter total laps"
                           min="1"
                           max="1000">
                </div>
                
                <div class="form-group">
                    <label for="seasonId">Season: <span style="color: red;">*</span></label>
                    <select id="seasonId" name="seasonId" class="form-control">
                        <option value="">-- Select Season --</option>
                        <% 
                        if (seasons != null && !seasons.isEmpty()) {
                            for (Season season : seasons) {
                        %>
                            <option value="<%= season.getId() %>"><%= season.getName() %> (<%= season.getYear() %>)</option>
                        <% 
                            }
                        }
                        %>
                    </select>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Add Stage</button>
                    <a href="stageList.jsp" class="back-button">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
