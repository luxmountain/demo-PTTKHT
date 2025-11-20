<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bảng xếp hạng đội đua</title>
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
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 40px;
        }
        .filter-section {
            margin: 30px 0;
            padding: 30px;
            background: #f9f9f9;
            border-radius: 5px;
            text-align: center;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .view-type-options {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 30px 0;
        }
        .option-card {
            flex: 1;
            max-width: 300px;
            padding: 30px;
            background: white;
            border: 3px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }
        .option-card:hover {
            border-color: #007bff;
            background: #f0f8ff;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }
        .option-card input[type="radio"] {
            display: none;
        }
        .option-card.selected {
            border-color: #007bff;
            background: #e7f3ff;
        }
        .option-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .option-title {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .option-description {
            font-size: 14px;
            color: #666;
        }
        .btn {
            display: inline-block;
            padding: 15px 40px;
            margin: 20px 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
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
        .action-section {
            text-align: center;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bảng xếp hạng đội đua</h1>
        
        <div class="filter-section">
            <h2>Chọn kiểu xem bảng xếp hạng</h2>
            
            <div class="view-type-options">
                <div class="option-card selected" onclick="selectOption('season', this)">
                    <input type="radio" name="viewType" value="season" checked>
                    <div class="option-icon">🏆</div>
                    <div class="option-title">Xem theo mùa giải</div>
                    <div class="option-description">Xem bảng xếp hạng tổng hợp của cả mùa giải</div>
                </div>
                
                <div class="option-card" onclick="selectOption('stage', this)">
                    <input type="radio" name="viewType" value="stage">
                    <div class="option-icon">🚴</div>
                    <div class="option-title">Xem theo chặng đua</div>
                    <div class="option-description">Xem bảng xếp hạng của từng chặng đua</div>
                </div>
            </div>

            <div class="action-section">
                <button type="button" class="btn" onclick="continueToSelection()">
                    Tiếp tục
                </button>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="userHome.jsp" class="btn btn-secondary">Quay về màn hình chính</a>
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
