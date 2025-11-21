package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for managing race results
 * @author ADMIN
 */
public class ResultDAO extends DAO {

    public ResultDAO() {
        super();
    }

    /**
     * Update result for a register
     * @param registerId the register ID
     * @param lapsCompleted the number of laps completed
     * @param timedone the completion time
     * @param points the points earned
     * @return true if successful
     */
    public boolean updateResult(int registerId, Integer lapsCompleted, Time timedone, Integer points) {
        String sql = "UPDATE tblregister SET laps_completed = ?, timedone = ?, points = ? WHERE id = ?";
        
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
            
            if (points != null) {
                ps.setInt(3, points);
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            
            ps.setInt(4, registerId);
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Calculate and update points for all racers in a stage based on finishing position
     * Only racers who completed all laps get points
     * Points system: 1st=25, 2nd=18, 3rd=15, 4th=12, 5th=10, 6th=8, 7th=6, 8th=4, 9th=2, 10th=1
     * 
     * @param stageId the stage ID
     * @return true if successful
     */
    public boolean calculateAndUpdatePointsForStage(int stageId) {
        try {
            // First, get total laps for this stage
            String sqlGetLaps = "SELECT total_laps FROM tblstage WHERE id = ?";
            PreparedStatement psGetLaps = con.prepareStatement(sqlGetLaps);
            psGetLaps.setInt(1, stageId);
            ResultSet rsLaps = psGetLaps.executeQuery();
            
            int totalLaps = 0;
            if (rsLaps.next()) {
                totalLaps = rsLaps.getInt("total_laps");
            }
            rsLaps.close();
            psGetLaps.close();
            
            // Get all registers for this stage who completed all laps, ordered by time
            String sqlGetFinishers = "SELECT id FROM tblregister "
                    + "WHERE tblStageid = ? AND laps_completed >= ? AND timedone IS NOT NULL "
                    + "ORDER BY timedone ASC";
            
            PreparedStatement psGetFinishers = con.prepareStatement(sqlGetFinishers);
            psGetFinishers.setInt(1, stageId);
            psGetFinishers.setInt(2, totalLaps);
            ResultSet rsFinishers = psGetFinishers.executeQuery();
            
            // Points system
            int[] pointsTable = {25, 18, 15, 12, 10, 8, 6, 4, 2, 1};
            
            List<Integer> finisherIds = new ArrayList<>();
            while (rsFinishers.next()) {
                finisherIds.add(rsFinishers.getInt("id"));
            }
            rsFinishers.close();
            psGetFinishers.close();
            
            // Update points for finishers
            String sqlUpdatePoints = "UPDATE tblregister SET points = ? WHERE id = ?";
            PreparedStatement psUpdatePoints = con.prepareStatement(sqlUpdatePoints);
            
            for (int i = 0; i < finisherIds.size(); i++) {
                int points = 0;
                if (i < pointsTable.length) {
                    points = pointsTable[i];
                }
                
                psUpdatePoints.setInt(1, points);
                psUpdatePoints.setInt(2, finisherIds.get(i));
                psUpdatePoints.executeUpdate();
            }
            psUpdatePoints.close();
            
            // Set points to 0 for DNF racers (didn't complete all laps)
            String sqlResetDNF = "UPDATE tblregister SET points = 0 "
                    + "WHERE tblStageid = ? AND (laps_completed < ? OR timedone IS NULL)";
            PreparedStatement psResetDNF = con.prepareStatement(sqlResetDNF);
            psResetDNF.setInt(1, stageId);
            psResetDNF.setInt(2, totalLaps);
            psResetDNF.executeUpdate();
            psResetDNF.close();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
