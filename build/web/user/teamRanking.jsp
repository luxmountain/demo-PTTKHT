<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team Rankings</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Team Rankings</h1>
        
        <div class="filter-section">
            <h2>Choose ranking view type</h2>
            
            <div class="view-type-options">
                <div class="option-card selected" onclick="selectOption('season', this)">
                    <input type="radio" name="viewType" value="season" checked>
                    <div class="option-icon">🏆</div>
                    <div class="option-title">View by Season</div>
                    <div class="option-description">View season-wide rankings</div>
                </div>
                
                <div class="option-card" onclick="selectOption('stage', this)">
                    <input type="radio" name="viewType" value="stage">
                    <div class="option-icon">🚴</div>
                    <div class="option-title">View by Stage</div>
                    <div class="option-description">View rankings for a specific stage</div>
                </div>
            </div>

            <div class="action-section">
                <button type="button" class="btn" onclick="continueToSelection()">
                    Continue
                </button>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="userHome.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>

    <script>
        function selectOption(type, element) {
            // Remove selected class from all cards
            var cards = document.querySelectorAll('.option-card');
            cards.forEach(function(card) {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            element.classList.add('selected');
            
            // Check the radio button
            var radio = element.querySelector('input[type="radio"]');
            radio.checked = true;
        }

        function continueToSelection() {
            var viewType = document.querySelector('input[name="viewType"]:checked').value;
            
            if (viewType === 'season') {
                window.location.href = 'seasonSelection.jsp';
            } else if (viewType === 'stage') {
                window.location.href = 'stageSelection.jsp';
            }
        }
    </script>
</body>
</html>
