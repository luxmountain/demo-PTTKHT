# Stage Search Feature - Implementation Summary

## Overview
Complete implementation of user stage search functionality following the sequence diagram (steps 1-37).

## Components Created/Modified

### Model Classes
1. **Stage.java** - Updated with complete fields:
   - id, name, date, location, description, roadmap, status, seasonId
   - All getters and setters

2. **User.java & Admin.java** - Already exist, extend Member class

### DAO Classes
1. **UserDAO.java** - New
   - `getUserInfo(int memberId)` - Fetches user details by joining tbluser and tblmember

2. **AdminDAO.java** - New
   - `getAdminInfo(int memberId)` - Fetches admin details by joining tbladmin and tblmember

3. **StageDAO.java** - New
   - `searchStage(String keyword)` - Searches stages by name, location, or description
   - `getStageInfo(int stageId)` - Gets detailed information for a specific stage

4. **MemberDAO.java** - Modified
   - Changed `checkLogin()` to return Member object (User or Admin)
   - Calls UserDAO or AdminDAO based on role after authentication

### JSP Pages

#### Login Flow (Updated)
1. **login.jsp** - Login form (existing)
2. **doLogin.jsp** - Modified to work with new MemberDAO return type
3. **userHome.jsp** - Updated with search link menu
4. **adminHome.jsp** - Created for admin users

#### Search Flow (New)
5. **searchStage.jsp** - Search form for entering keywords
6. **doSearchStage.jsp** - Processes search and calls StageDAO
7. **stageListSearch.jsp** - Displays search results in a table
8. **stageDetail.jsp** - Shows detailed information for selected stage

## User Flow

### Login Flow (Steps 1-15)
```
1. User accesses login.jsp
2. User fills login form
3. login.jsp → doLogin.jsp
4. doLogin.jsp → MemberDAO.checkLogin()
5. MemberDAO → Member (encapsulate info)
6. Member returns to checkLogin()
7. MemberDAO calls UserDAO/AdminDAO based on role
8. UserDAO.getUserInfo() is called
9. getUserInfo() → User (encapsulate info)
10. User returns to getUserInfo()
11. getUserInfo() returns to doLogin.jsp
12. doLogin.jsp → userHome.jsp
13. userHome.jsp displays for user
```

### Search Flow (Steps 16-37)
```
14. User clicks "Search Stages" link
15. userHome.jsp → searchStage.jsp
16. searchStage.jsp displays search form
17. User enters keyword and clicks search
18. searchStage.jsp → doSearchStage.jsp
19. doSearchStage.jsp → StageDAO
20. StageDAO.searchStage() is called
21. searchStage() → Stage (encapsulate info)
22. Stage returns to searchStage()
23. searchStage() returns to doSearchStage.jsp
24. doSearchStage.jsp → stageListSearch.jsp
25. stageListSearch.jsp displays results
26. User clicks on a stage
27. stageListSearch.jsp → stageDetail.jsp
28. stageDetail.jsp → StageDAO
29. StageDAO.getStageInfo() is called
30. getStageInfo() → Stage
31. Stage returns to getStageInfo()
32. getStageInfo() returns to stageDetail.jsp
33. stageDetail.jsp displays stage details
```

## Database Tables Used
- `tblmember` - Member authentication and basic info
- `tbluser` - User role mapping (FK: tblMemberid)
- `tbladmin` - Admin role mapping (FK: tblMemberid)
- `tblstage` - Stage information
- `tblseason` - Referenced by tblstage (FK: tblSeasonid)

## Features
1. **Secure Login** - SQL injection prevention with parameterized queries
2. **Role-Based Access** - Separate User and Admin objects with specific DAO methods
3. **Search Functionality** - Keyword search across stage name, location, and description
4. **Search Results Display** - Clean table view with pagination-ready structure
5. **Stage Details** - Comprehensive detail view with formatted dates and status badges
6. **Session Management** - Proper session timeout handling
7. **Navigation** - Easy navigation between search, results, and details

## Testing Steps

1. **Insert test data:**
```sql
-- Create test member
INSERT INTO tblmember (username, name, password, email) 
VALUES ('testuser', 'Test User', 'password123', 'test@example.com');

-- Add to tbluser
INSERT INTO tbluser (tblMemberid) VALUES (LAST_INSERT_ID());

-- Create test season
INSERT INTO tblseason (name, year, startdate, enddate) 
VALUES ('Season 2025', 2025, '2025-01-01', '2025-12-31');

-- Create test stages
INSERT INTO tblstage (name, date, location, description, roadmap, status, tblSeasonid) 
VALUES 
('Mountain Stage', '2025-03-15', 'Alps', 'Challenging mountain route', 'Alps Circuit', 1, 1),
('Sprint Stage', '2025-03-20', 'Paris', 'Fast flat sprint stage', 'City Center', 1, 1),
('Time Trial', '2025-03-25', 'Lyon', 'Individual time trial', 'River Route', 1, 1);
```

2. **Test the flow:**
   - Login with testuser/password123
   - Click "Search Stages" from user home
   - Search for "Mountain" or "Paris" or "Stage"
   - View search results
   - Click "View Details" on any stage
   - Navigate back through the pages

## File Structure
```
web/
├── login.jsp
├── doLogin.jsp
├── user/
│   ├── userHome.jsp
│   ├── searchStage.jsp
│   ├── doSearchStage.jsp
│   ├── stageListSearch.jsp
│   └── stageDetail.jsp
├── admin/
│   └── adminHome.jsp

src/java/
├── model/
│   ├── Member.java
│   ├── User.java
│   ├── Admin.java
│   └── Stage.java
└── dao/
    ├── DAO.java
    ├── MemberDAO.java
    ├── UserDAO.java
    ├── AdminDAO.java
    └── StageDAO.java
```

## Notes
- All pages include session validation
- SQL queries use PreparedStatement for security
- Date formatting using SimpleDateFormat (dd/MM/yyyy)
- Responsive styling with CSS
- Error handling for invalid inputs
- Clean separation of concerns (Model-DAO-View)
