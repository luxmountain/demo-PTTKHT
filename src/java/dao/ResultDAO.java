package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import model.Register;
import model.Result;

/**
 * DAO for managing race results
 * @author ADMIN
 */
public class ResultDAO extends DAO {

    public ResultDAO() {
        super();
    }

    /**
     * Get all racers registered for a specific stage with their current results
     * @param stageId the stage ID
     * @return list of Register objects with Result data
     */
    public List<Register> getRegistersByStage(int stageId) {
        List<Register> registers = new ArrayList<>();
        
        String sql = "SELECT r.id as register_id, r.dateregistered, r.status, "
                + "r.tblContractid as contract_id, r.tblStageid as stage_id, "
                + "m.id as racer_id, m.name as racer_name, "
                + "t.name as team_name, "
                + "r.position, r.timedone, r.points "
                + "FROM tblregister r "
                + "INNER JOIN tblcontract c ON r.tblContractid = c.id "
                + "INNER JOIN tblracer ra ON c.tblRacerid = ra.id "
                + "INNER JOIN tblmember m ON ra.tblMemberid = m.id "
                + "INNER JOIN tblteam t ON c.tblTeamid = t.id "
                + "WHERE r.tblStageid = ? "
                + "ORDER BY CASE WHEN r.timedone IS NULL THEN 1 ELSE 0 END, r.timedone, m.name";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageId);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Register register = new Register();
                register.setId(rs.getInt("register_id"));
                register.setDateRegistered(rs.getDate("dateregistered"));
                register.setStatus(rs.getBoolean("status"));
                register.setContractId(rs.getInt("contract_id"));
                register.setStageId(rs.getInt("stage_id"));
                
                // Set display fields
                register.setRacerName(rs.getString("racer_name"));
                register.setTeamName(rs.getString("team_name"));
                
                // Create and set Result object
                Result result = new Result();
                
                int position = rs.getInt("position");
                if (!rs.wasNull()) {
                    result.setPosition(position);
                }
                
                Time timedone = rs.getTime("timedone");
                result.setTimedone(timedone);
                
                int points = rs.getInt("points");
                if (!rs.wasNull()) {
                    result.setPoints(points);
                }
                
                register.setResult(result);
                registers.add(register);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return registers;
    }

    /**
     * Update result for a register
     * @param registerId the register ID
     * @param position the position/rank
     * @param timedone the completion time
     * @param points the points earned
     * @return true if successful
     */
    public boolean updateResult(int registerId, Integer position, Time timedone, Integer points) {
        String sql = "UPDATE tblregister SET position = ?, timedone = ?, points = ? WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            
            if (position != null) {
                ps.setInt(1, position);
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
