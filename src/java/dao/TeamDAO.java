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
     * Reads from tblstatteaminseason table
     * @param seasonId the season ID
     * @return list of teams with their rankings
     */
    public List<Map<String, Object>> getTeamRankingsBySeason(int seasonId) {
        List<Map<String, Object>> rankings = new ArrayList<>();
        
        String sql = "SELECT t.id, t.name, t.nation, t.status, "
                + "COALESCE(sts.totalpoints, 0) as totalPoints, "
                + "COUNT(DISTINCT stg_sts.tblStageid) as stagesParticipated "
                + "FROM tblteam t "
                + "LEFT JOIN tblstatteaminseason sts ON t.id = sts.tblTeamid AND sts.tblSeasonid = ? "
                + "LEFT JOIN tblstage s ON s.tblSeasonid = ? "
                + "LEFT JOIN tblstatteaminstage stg_sts ON t.id = stg_sts.tblTeamid AND s.id = stg_sts.tblStageid "
                + "WHERE sts.totalpoints IS NOT NULL OR stg_sts.totalpoints IS NOT NULL "
                + "GROUP BY t.id, t.name, t.nation, t.status, sts.totalpoints "
                + "ORDER BY totalPoints DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seasonId);
            ps.setInt(2, seasonId);
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
     * Reads from tblstatteaminseason table
     * @param teamId the team ID
     * @param seasonId the season ID
     * @return map with totalPoints and rank
     */
    public Map<String, Object> getTeamSeasonStats(int teamId, int seasonId) {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            // Get total points from stat table if present
            String sqlPoints = "SELECT COALESCE(totalpoints, 0) as totalPoints "
                    + "FROM tblstatteaminseason WHERE tblTeamid = ? AND tblSeasonid = ?";
            PreparedStatement psPoints = con.prepareStatement(sqlPoints);
            psPoints.setInt(1, teamId);
            psPoints.setInt(2, seasonId);
            ResultSet rsPoints = psPoints.executeQuery();
            int totalPoints = 0;
            if (rsPoints.next()) {
                totalPoints = rsPoints.getInt("totalPoints");
            }
            rsPoints.close();
            psPoints.close();

            stats.put("totalPoints", totalPoints);

            // Compute rank: count how many teams have more points in the same season
            if (totalPoints > 0) {
                String sqlRank = "SELECT COUNT(*) as higher FROM tblstatteaminseason WHERE tblSeasonid = ? AND totalpoints > ?";
                PreparedStatement psRank = con.prepareStatement(sqlRank);
                psRank.setInt(1, seasonId);
                psRank.setInt(2, totalPoints);
                ResultSet rsRank = psRank.executeQuery();
                int higher = 0;
                if (rsRank.next()) higher = rsRank.getInt("higher");
                rsRank.close();
                psRank.close();

                stats.put("rank", higher + 1);
            } else {
                stats.put("rank", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            stats.put("totalPoints", 0);
            stats.put("rank", 0);
        }

        return stats;
    }

    /**
     * Get team rankings by stage
     * Reads from tblstatteaminstage table
     * @param stageId the stage ID
     * @return list of teams with their rankings in that stage
     */
    public List<Map<String, Object>> getTeamRankingsByStage(int stageId) {
        List<Map<String, Object>> rankings = new ArrayList<>();
        
        String sql = "SELECT t.id, t.name, t.nation, t.status, "
                + "COALESCE(sts.totalpoints, 0) as totalPoints, "
                + "COUNT(DISTINCT r.id) as racersParticipated, "
                + "MIN(ranked.position) as bestPosition "
                + "FROM tblteam t "
                + "LEFT JOIN tblstatteaminstage sts ON t.id = sts.tblTeamid AND sts.tblStageid = ? "
                + "LEFT JOIN tblcontract c ON t.id = c.tblTeamid AND c.status = 1 "
                + "LEFT JOIN tblregister r ON c.id = r.tblContractid AND r.status = 1 AND r.tblStageid = ? "
                + "LEFT JOIN ( "
                + "  SELECT reg.id, RANK() OVER (ORDER BY reg.timedone ASC) as position "
                + "  FROM tblregister reg "
                + "  JOIN tblstage st ON reg.tblStageid = st.id "
                + "  WHERE reg.tblStageid = ? AND reg.laps_completed >= st.total_laps AND reg.timedone IS NOT NULL "
                + ") ranked ON r.id = ranked.id "
                + "WHERE sts.totalpoints IS NOT NULL AND sts.totalpoints > 0 "
                + "GROUP BY t.id, t.name, t.nation, t.status, sts.totalpoints "
                + "ORDER BY totalPoints DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageId);
            ps.setInt(2, stageId);
            ps.setInt(3, stageId);
            ResultSet rs = ps.executeQuery();

            int rank = 1;
            while (rs.next()) {
                Map<String, Object> teamRanking = new HashMap<>();
                teamRanking.put("rank", rank++);
                teamRanking.put("teamId", rs.getInt("id"));
                teamRanking.put("teamName", rs.getString("name"));
                teamRanking.put("nation", rs.getString("nation"));
                teamRanking.put("racersParticipated", rs.getInt("racersParticipated"));
                teamRanking.put("bestPosition", rs.getObject("bestPosition"));
                teamRanking.put("totalPoints", rs.getInt("totalPoints"));
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
        
        String sql = "SELECT m.id, m.name, r.shirtnumber, r.nationality, "
                + "reg.laps_completed, reg.timedone "
                + "FROM tblmember m "
                + "JOIN tblracer r ON m.id = r.tblMemberid "
                + "JOIN tblcontract c ON r.id = c.tblRacerid "
                + "JOIN tblregister reg ON c.id = reg.tblContractid "
                + "WHERE c.tblTeamid = ? AND reg.tblStageid = ? AND reg.status = 1 "
                + "ORDER BY reg.timedone ASC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, teamId);
            ps.setInt(2, stageId);
            ResultSet rs = ps.executeQuery();
            
            List<Map<String, Object>> tempRacers = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> racer = new HashMap<>();
                racer.put("racerId", rs.getInt("id"));
                racer.put("racerName", rs.getString("name"));
                racer.put("shirtNumber", rs.getInt("shirtnumber"));
                racer.put("nationality", rs.getString("nationality"));
                racer.put("lapsCompleted", rs.getInt("laps_completed"));
                racer.put("timeDone", rs.getTime("timedone"));
                
                tempRacers.add(racer);
            }
            
            rs.close();
            ps.close();
            
            if (!tempRacers.isEmpty()) {
                String stageSql = "SELECT total_laps FROM tblstage WHERE id = ?";
                PreparedStatement stagePs = con.prepareStatement(stageSql);
                stagePs.setInt(1, stageId);
                ResultSet stageRs = stagePs.executeQuery();
                
                stageRs.close();
                stagePs.close();
                
                String positionSql = "SELECT reg.id as regId, c.tblRacerid, "
                    + "RANK() OVER (ORDER BY reg.timedone ASC) as position "
                    + "FROM tblregister reg "
                    + "JOIN tblcontract c ON reg.tblContractid = c.id "
                    + "JOIN tblstage st ON reg.tblStageid = st.id "
                    + "WHERE reg.tblStageid = ? AND reg.laps_completed >= st.total_laps AND reg.timedone IS NOT NULL AND reg.status = 1";
                
                PreparedStatement posPs = con.prepareStatement(positionSql);
                posPs.setInt(1, stageId);
                ResultSet posRs = posPs.executeQuery();
                
                Map<Integer, Integer> racerPositions = new HashMap<>();
                while (posRs.next()) {
                    racerPositions.put(posRs.getInt("tblRacerid"), posRs.getInt("position"));
                }
                posRs.close();
                posPs.close();
                
                // Add position and calculate points based on position
                for (Map<String, Object> racer : tempRacers) {
                    Integer racerId = (Integer) racer.get("racerId");
                    Integer position = racerPositions.get(racerId);
                    racer.put("position", position != null ? position : 0);
                    
                    if (position != null && position > 0) {
                        int points = Math.max(0, 26 - position);
                        racer.put("points", points);
                    } else {
                        racer.put("points", 0);
                    }
                    
                    racers.add(racer);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return racers;
    }
}
