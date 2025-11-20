package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Team;

public class TeamDAO extends DAO {

    public TeamDAO() {
        super();
    }

    /**
     * Get team rankings by season
     * @param seasonId the season ID
     * @return list of teams with their rankings
     */
    public List<Map<String, Object>> getTeamRankingsBySeason(int seasonId) {
        List<Map<String, Object>> rankings = new ArrayList<>();
        
        String sql = "SELECT t.id, t.name, t.nation, t.status, "
                + "COUNT(DISTINCT r.tblStageid) as stagesParticipated, "
                + "COALESCE(SUM(r.points), 0) as totalPoints, "
                + "SUM(CASE WHEN r.position = 1 THEN 1 ELSE 0 END) as wins "
                + "FROM tblteam t "
                + "LEFT JOIN tblcontract c ON t.id = c.tblTeamid AND c.status = 1 "
                + "LEFT JOIN tblregister r ON c.id = r.tblContractid AND r.status = 1 "
                + "LEFT JOIN tblstage s ON r.tblStageid = s.id "
                + "WHERE s.tblSeasonid = ? OR s.tblSeasonid IS NULL "
                + "GROUP BY t.id, t.name, t.nation, t.status "
                + "ORDER BY totalPoints DESC, wins DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seasonId);
            ResultSet rs = ps.executeQuery();
            
            int rank = 1;
            while (rs.next()) {
                Map<String, Object> teamRanking = new HashMap<>();
                teamRanking.put("rank", rank++);
                teamRanking.put("teamId", rs.getInt("id"));
                teamRanking.put("teamName", rs.getString("name"));
                teamRanking.put("nation", rs.getString("nation"));
                teamRanking.put("stagesParticipated", rs.getInt("stagesParticipated"));
                teamRanking.put("totalPoints", rs.getInt("totalPoints"));
                teamRanking.put("wins", rs.getInt("wins"));
                teamRanking.put("status", rs.getBoolean("status"));
                
                rankings.add(teamRanking);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return rankings;
    }

    /**
     * Get team details by team ID
     * @param teamId the team ID
     * @return Team object
     */
    public Team getTeamById(int teamId) {
        Team team = null;
        
        String sql = "SELECT id, name, description, nation, totalpoints, status "
                + "FROM tblteam WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, teamId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                team = new Team();
                team.setId(rs.getInt("id"));
                team.setName(rs.getString("name"));
                team.setDescription(rs.getString("description"));
                team.setNation(rs.getString("nation"));
                team.setTotalpoints(rs.getInt("totalpoints"));
                team.setStatus(rs.getBoolean("status"));
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return team;
    }

    /**
     * Get racers in a team for a specific season
     * @param teamId the team ID
     * @param seasonId the season ID
     * @return list of racers with their details
     */
    public List<Map<String, Object>> getRacersByTeam(int teamId, int seasonId) {
        List<Map<String, Object>> racers = new ArrayList<>();
        
        String sql = "SELECT DISTINCT m.id, m.name, r.nationality, r.shirtnumber "
                + "FROM tblmember m "
                + "JOIN tblracer r ON m.id = r.tblMemberid "
                + "JOIN tblcontract c ON r.id = c.tblRacerid "
                + "JOIN tblregister reg ON c.id = reg.tblContractid "
                + "JOIN tblstage s ON reg.tblStageid = s.id "
                + "WHERE c.tblTeamid = ? AND s.tblSeasonid = ? AND c.status = 1 AND r.status = 1 "
                + "ORDER BY m.name";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, teamId);
            ps.setInt(2, seasonId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> racer = new HashMap<>();
                racer.put("racerId", rs.getInt("id"));
                racer.put("racerName", rs.getString("name"));
                racer.put("nationality", rs.getString("nationality"));
                racer.put("shirtNumber", rs.getInt("shirtnumber"));
                
                racers.add(racer);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return racers;
    }

    /**
     * Get team performance by stage for a specific season
     * @param teamId the team ID
     * @param seasonId the season ID
     * @return list of stage performances
     */
    public List<Map<String, Object>> getTeamPerformanceByStage(int teamId, int seasonId) {
        List<Map<String, Object>> performances = new ArrayList<>();
        
        String sql = "SELECT s.name as stageName, s.date as stageDate, "
                + "MIN(reg.position) as bestPosition, "
                + "SUM(reg.points) as totalPoints "
                + "FROM tblstage s "
                + "LEFT JOIN tblregister reg ON s.id = reg.tblStageid AND reg.status = 1 "
                + "LEFT JOIN tblcontract c ON reg.tblContractid = c.id AND c.tblTeamid = ? "
                + "WHERE s.tblSeasonid = ? "
                + "GROUP BY s.id, s.name, s.date "
                + "ORDER BY s.date";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, teamId);
            ps.setInt(2, seasonId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> performance = new HashMap<>();
                performance.put("stageName", rs.getString("stageName"));
                performance.put("stageDate", rs.getDate("stageDate"));
                
                Object bestPos = rs.getObject("bestPosition");
                performance.put("bestPosition", bestPos != null ? rs.getInt("bestPosition") : null);
                performance.put("totalPoints", rs.getInt("totalPoints"));
                
                performances.add(performance);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return performances;
    }

    /**
     * Get team's total points and rank in a season
     * @param teamId the team ID
     * @param seasonId the season ID
     * @return map with totalPoints and rank
     */
    public Map<String, Object> getTeamSeasonStats(int teamId, int seasonId) {
        Map<String, Object> stats = new HashMap<>();
        
        // Get total points
        String sql1 = "SELECT COALESCE(SUM(reg.points), 0) as totalPoints "
                + "FROM tblregister reg "
                + "JOIN tblcontract c ON reg.tblContractid = c.id "
                + "JOIN tblstage s ON reg.tblStageid = s.id "
                + "WHERE c.tblTeamid = ? AND s.tblSeasonid = ? AND reg.status = 1";
        
        try {
            PreparedStatement ps1 = con.prepareStatement(sql1);
            ps1.setInt(1, teamId);
            ps1.setInt(2, seasonId);
            ResultSet rs1 = ps1.executeQuery();
            
            if (rs1.next()) {
                stats.put("totalPoints", rs1.getInt("totalPoints"));
            }
            rs1.close();
            ps1.close();
            
            // Get rank - find position among all teams in the season
            String sql2 = "SELECT team_rank FROM ( "
                    + "SELECT c.tblTeamid, "
                    + "RANK() OVER (ORDER BY SUM(reg.points) DESC) as team_rank "
                    + "FROM tblregister reg "
                    + "JOIN tblcontract c ON reg.tblContractid = c.id "
                    + "JOIN tblstage s ON reg.tblStageid = s.id "
                    + "WHERE s.tblSeasonid = ? AND reg.status = 1 "
                    + "GROUP BY c.tblTeamid "
                    + ") ranked_teams "
                    + "WHERE tblTeamid = ?";
            
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setInt(1, seasonId);
            ps2.setInt(2, teamId);
            ResultSet rs2 = ps2.executeQuery();
            
            if (rs2.next()) {
                stats.put("rank", rs2.getInt("team_rank"));
            } else {
                // If team has no data in this season, set rank as N/A
                stats.put("rank", 0);
            }
            rs2.close();
            ps2.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return stats;
    }

    /**
     * Get team rankings by stage
     * @param stageId the stage ID
     * @return list of teams with their rankings in that stage
     */
    public List<Map<String, Object>> getTeamRankingsByStage(int stageId) {
        List<Map<String, Object>> rankings = new ArrayList<>();
        
        String sql = "SELECT t.id, t.name, t.nation, t.status, "
                + "COUNT(DISTINCT r.id) as racersParticipated, "
                + "COALESCE(SUM(r.points), 0) as totalPoints, "
                + "MIN(r.position) as bestPosition "
                + "FROM tblteam t "
                + "LEFT JOIN tblcontract c ON t.id = c.tblTeamid AND c.status = 1 "
                + "LEFT JOIN tblregister r ON c.id = r.tblContractid AND r.status = 1 AND r.tblStageid = ? "
                + "GROUP BY t.id, t.name, t.nation, t.status "
                + "HAVING totalPoints > 0 "
                + "ORDER BY totalPoints DESC, bestPosition ASC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageId);
            ResultSet rs = ps.executeQuery();
            
            int rank = 1;
            while (rs.next()) {
                Map<String, Object> teamRanking = new HashMap<>();
                teamRanking.put("rank", rank++);
                teamRanking.put("teamId", rs.getInt("id"));
                teamRanking.put("teamName", rs.getString("name"));
                teamRanking.put("nation", rs.getString("nation"));
                teamRanking.put("racersParticipated", rs.getInt("racersParticipated"));
                teamRanking.put("totalPoints", rs.getInt("totalPoints"));
                teamRanking.put("bestPosition", rs.getObject("bestPosition"));
                teamRanking.put("status", rs.getBoolean("status"));
                
                rankings.add(teamRanking);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return rankings;
    }

    /**
     * Get racers performance in a specific stage for a team
     * @param teamId the team ID
     * @param stageId the stage ID
     * @return list of racers with their performance
     */
    public List<Map<String, Object>> getTeamRacersInStage(int teamId, int stageId) {
        List<Map<String, Object>> racers = new ArrayList<>();
        
        String sql = "SELECT m.id, m.name, r.shirtnumber, "
                + "reg.position, reg.timedone, reg.points "
                + "FROM tblmember m "
                + "JOIN tblracer r ON m.id = r.tblMemberid "
                + "JOIN tblcontract c ON r.id = c.tblRacerid "
                + "JOIN tblregister reg ON c.id = reg.tblContractid "
                + "WHERE c.tblTeamid = ? AND reg.tblStageid = ? AND reg.status = 1 "
                + "ORDER BY reg.position ASC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, teamId);
            ps.setInt(2, stageId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> racer = new HashMap<>();
                racer.put("racerId", rs.getInt("id"));
                racer.put("racerName", rs.getString("name"));
                racer.put("shirtNumber", rs.getInt("shirtnumber"));
                racer.put("position", rs.getInt("position"));
                racer.put("timeDone", rs.getTime("timedone"));
                racer.put("points", rs.getInt("points"));
                
                racers.add(racer);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return racers;
    }
}
