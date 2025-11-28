package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;

/**
 * DAO for managing race results
 * 
 * @author ADMIN
 */
public class ResultDAO extends DAO {

    public ResultDAO() {
        super();
    }

    /**
     * Update result for a register
     * 
     * @param registerId    the register ID
     * @param lapsCompleted the number of laps completed
     * @param timedone      the completion time
     * @param points        the points earned (deprecated - not used, stats
     *                      calculated separately)
     * @return true if successful
     */
    public boolean updateResult(int registerId, Integer lapsCompleted, Time timedone, Integer points) {
        String sql = "UPDATE tblregister SET laps_completed = ?, timedone = ? WHERE id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);

            if (lapsCompleted != null) {
                ps.setInt(1, lapsCompleted);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }

            if (timedone != null) {
                ps.setTime(2, timedone);
            } else {
                ps.setNull(2, java.sql.Types.TIME);
            }

            ps.setInt(3, registerId);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Calculate and update team statistics for a stage
     * Updates tblstatteaminstage and tblstatteaminseason tables
     * Points system: 1st=25, 2nd=18, 3rd=15, 4th=12, 5th=10, 6th=8, 7th=6, 8th=4,
     * 9th=2, 10th=1
     * 
     * @param stageId the stage ID
     * @return true if successful
     */
    public boolean calculateAndUpdatePointsForStage(int stageId) {
        try {
            // Get stage info (total laps and season id)
            String sqlGetStage = "SELECT total_laps, tblSeasonid FROM tblstage WHERE id = ?";
            PreparedStatement psGetStage = con.prepareStatement(sqlGetStage);
            psGetStage.setInt(1, stageId);
            ResultSet rsStage = psGetStage.executeQuery();

            int totalLaps = 0;
            int seasonId = 0;
            if (rsStage.next()) {
                totalLaps = rsStage.getInt("total_laps");
                seasonId = rsStage.getInt("tblSeasonid");
            }
            rsStage.close();
            psGetStage.close();

            if (totalLaps == 0 || seasonId == 0) {
                return false;
            }

            updateTeamStatsForStage(stageId, totalLaps);

            updateTeamStatsForSeason(seasonId);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update team statistics for a specific stage
     * Calculates points based on racers' finishing positions and updates
     * tblstatteaminstage
     * 
     * @param stageId   the stage ID
     * @param totalLaps the total laps for this stage
     * @return true if successful
     */
    private boolean updateTeamStatsForStage(int stageId, int totalLaps) {
        try {
            String sqlDelete = "DELETE FROM tblstatteaminstage WHERE tblStageid = ?";
            PreparedStatement psDelete = con.prepareStatement(sqlDelete);
            psDelete.setInt(1, stageId);
            psDelete.executeUpdate();
            psDelete.close();

            String sqlInsert = "INSERT INTO tblstatteaminstage (tblTeamid, tblStageid, totalpoints) "
                    + "SELECT team_points.tblTeamid, ?, SUM(team_points.points) as totalpoints "
                    + "FROM ( "
                    + "  SELECT c.tblTeamid, "
                    + "    CASE "
                    + "      WHEN r.laps_completed == ? AND r.timedone IS NOT NULL THEN "
                    + "        CASE racer_rank "
                    + "          WHEN 1 THEN 25 "
                    + "          WHEN 2 THEN 18 "
                    + "          WHEN 3 THEN 15 "
                    + "          WHEN 4 THEN 12 "
                    + "          WHEN 5 THEN 10 "
                    + "          WHEN 6 THEN 8 "
                    + "          WHEN 7 THEN 6 "
                    + "          WHEN 8 THEN 4 "
                    + "          WHEN 9 THEN 2 "
                    + "          WHEN 10 THEN 1 "
                    + "          ELSE 0 "
                    + "        END "
                    + "      ELSE 0 "
                    + "    END as points "
                    + "  FROM tblregister r "
                    + "  JOIN tblcontract c ON r.tblContractid = c.id "
                    + "  LEFT JOIN ( "
                    + "    SELECT id, RANK() OVER (ORDER BY timedone ASC) as racer_rank "
                    + "    FROM tblregister "
                    + "    WHERE tblStageid = ? AND laps_completed == ? AND timedone IS NOT NULL "
                    + "  ) ranked ON r.id = ranked.id "
                    + "  WHERE r.tblStageid = ? AND r.status = 1 "
                    + ") team_points "
                    + "GROUP BY team_points.tblTeamid "
                    + "HAVING totalpoints > 0";

            PreparedStatement psInsert = con.prepareStatement(sqlInsert);
            psInsert.setInt(1, stageId);
            psInsert.setInt(2, totalLaps);
            psInsert.setInt(3, stageId);
            psInsert.setInt(4, totalLaps);
            psInsert.setInt(5, stageId);
            psInsert.executeUpdate();
            psInsert.close();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update team statistics for an entire season
     * Aggregates points from all stages in the season and updates
     * tblstatteaminseason
     * 
     * @param seasonId the season ID
     * @return true if successful
     */
    private boolean updateTeamStatsForSeason(int seasonId) {
        try {
            String sqlDelete = "DELETE FROM tblstatteaminseason WHERE tblSeasonid = ?";
            PreparedStatement psDelete = con.prepareStatement(sqlDelete);
            psDelete.setInt(1, seasonId);
            psDelete.executeUpdate();
            psDelete.close();

            String sqlInsert = "INSERT INTO tblstatteaminseason (tblTeamid, tblSeasonid, totalpoints) "
                    + "SELECT sts.tblTeamid, ?, SUM(sts.totalpoints) as totalpoints "
                    + "FROM tblstatteaminstage sts "
                    + "JOIN tblstage s ON sts.tblStageid = s.id "
                    + "WHERE s.tblSeasonid = ? "
                    + "GROUP BY sts.tblTeamid "
                    + "HAVING totalpoints > 0";

            PreparedStatement psInsert = con.prepareStatement(sqlInsert);
            psInsert.setInt(1, seasonId);
            psInsert.setInt(2, seasonId);
            psInsert.executeUpdate();
            psInsert.close();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
