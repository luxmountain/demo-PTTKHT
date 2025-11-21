package dao;

import java.sql.PreparedStatement;
import java.sql.Time;

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
}
