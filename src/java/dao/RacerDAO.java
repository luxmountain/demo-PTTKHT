package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Racer;

public class RacerDAO extends DAO {

    public RacerDAO() {
        super();
    }

    /**
     * Get racer details by racer member ID
     * @param racerId the member ID
     * @return map with racer details
     */
    public Map<String, Object> getRacerDetails(int racerId) {
        Map<String, Object> racerDetails = new HashMap<>();
        
        String sql = "SELECT m.id, m.name, m.dob, r.nationality, r.shirtnumber "
                + "FROM tblmember m "
                + "JOIN tblracer r ON m.id = r.tblMemberid "
                + "WHERE m.id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, racerId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                racerDetails.put("racerId", rs.getInt("id"));
                racerDetails.put("racerName", rs.getString("name"));
                racerDetails.put("dob", rs.getDate("dob"));
                racerDetails.put("nationality", rs.getString("nationality"));
                racerDetails.put("shirtNumber", rs.getInt("shirtnumber"));
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return racerDetails;
    }

    /**
     * Get racer's team for a specific season
     * @param racerId the member ID
     * @param seasonId the season ID
     * @return team name
     */
    public String getRacerTeamInSeason(int racerId, int seasonId) {
        String teamName = null;
        
        String sql = "SELECT DISTINCT t.name "
                + "FROM tblteam t "
                + "JOIN tblcontract c ON t.id = c.tblTeamid "
                + "JOIN tblracer r ON c.tblRacerid = r.id "
                + "JOIN tblregister reg ON c.id = reg.tblContractid "
                + "JOIN tblstage s ON reg.tblStageid = s.id "
                + "WHERE r.tblMemberid = ? AND s.tblSeasonid = ? AND c.status = 1 "
                + "LIMIT 1";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, racerId);
            ps.setInt(2, seasonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                teamName = rs.getString("name");
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return teamName;
    }

    /**
     * Get racer's performance by stage in a season
     * @param racerId the member ID
     * @param seasonId the season ID
     * @return list of stage performances
     */
    public List<Map<String, Object>> getRacerPerformanceByStage(int racerId, int seasonId) {
        List<Map<String, Object>> performances = new ArrayList<>();
        
        String sql = "SELECT s.name as stageName, s.date as stageDate, "
                + "reg.position, reg.timedone, reg.points "
                + "FROM tblstage s "
                + "JOIN tblregister reg ON s.id = reg.tblStageid "
                + "JOIN tblcontract c ON reg.tblContractid = c.id "
                + "JOIN tblracer r ON c.tblRacerid = r.id "
                + "WHERE r.tblMemberid = ? AND s.tblSeasonid = ? AND reg.status = 1 "
                + "ORDER BY s.date";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, racerId);
            ps.setInt(2, seasonId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> performance = new HashMap<>();
                performance.put("stageName", rs.getString("stageName"));
                performance.put("stageDate", rs.getDate("stageDate"));
                performance.put("position", rs.getInt("position"));
                performance.put("timeDone", rs.getTime("timedone"));
                performance.put("points", rs.getInt("points"));
                
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
     * Get racer's season statistics
     * @param racerId the member ID
     * @param seasonId the season ID
     * @return map with statistics
     */
    public Map<String, Object> getRacerSeasonStats(int racerId, int seasonId) {
        Map<String, Object> stats = new HashMap<>();
        
        String sql = "SELECT COUNT(DISTINCT reg.tblStageid) as stagesParticipated, "
                + "COALESCE(SUM(reg.points), 0) as totalPoints "
                + "FROM tblregister reg "
                + "JOIN tblcontract c ON reg.tblContractid = c.id "
                + "JOIN tblracer r ON c.tblRacerid = r.id "
                + "JOIN tblstage s ON reg.tblStageid = s.id "
                + "WHERE r.tblMemberid = ? AND s.tblSeasonid = ? AND reg.status = 1";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, racerId);
            ps.setInt(2, seasonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                stats.put("stagesParticipated", rs.getInt("stagesParticipated"));
                stats.put("totalPoints", rs.getInt("totalPoints"));
            }
            
            rs.close();
            ps.close();
            
            // Get racer rank in season using RANK() function
            String sql2 = "SELECT racer_rank FROM ( "
                    + "SELECT r.tblMemberid, "
                    + "RANK() OVER (ORDER BY SUM(reg.points) DESC) as racer_rank "
                    + "FROM tblregister reg "
                    + "JOIN tblcontract c ON reg.tblContractid = c.id "
                    + "JOIN tblracer r ON c.tblRacerid = r.id "
                    + "JOIN tblstage s ON reg.tblStageid = s.id "
                    + "WHERE s.tblSeasonid = ? AND reg.status = 1 "
                    + "GROUP BY r.tblMemberid "
                    + ") ranked_racers "
                    + "WHERE tblMemberid = ?";
            
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setInt(1, seasonId);
            ps2.setInt(2, racerId);
            ResultSet rs2 = ps2.executeQuery();
            
            if (rs2.next()) {
                stats.put("rank", rs2.getInt("racer_rank"));
            } else {
                // If racer has no data in this season, set rank as 0
                stats.put("rank", 0);
            }
            rs2.close();
            ps2.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return stats;
    }
}
