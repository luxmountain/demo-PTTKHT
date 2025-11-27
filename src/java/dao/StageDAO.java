package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Stage;

public class StageDAO extends DAO {

    public StageDAO() {
        super();
    }

    /**
     * Search for stages by keyword (searches in name, location, description)
     * @param keyword the search keyword
     * @return list of matching stages
     */
    public List<Stage> searchStage(String keyword) {
        List<Stage> stages = new ArrayList<>();
        
        String sql = "SELECT id, name, date, location, description, roadmap, total_laps, status, tblSeasonid "
                + "FROM tblstage "
                + "WHERE (name LIKE ? OR location LIKE ? OR description LIKE ?) "
                + "AND status = 1 "
                + "ORDER BY date DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Stage stage = new Stage();
                stage.setId(rs.getInt("id"));
                stage.setName(rs.getString("name"));
                stage.setDate(rs.getDate("date"));
                stage.setLocation(rs.getString("location"));
                stage.setDescription(rs.getString("description"));
                stage.setRoadmap(rs.getString("roadmap"));
                stage.setTotalLaps(rs.getInt("total_laps"));
                stage.setStatus(rs.getBoolean("status"));
                stage.setSeasonId(rs.getInt("tblSeasonid"));
                
                stages.add(stage);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return stages;
    }

    /**
     * Get detailed information about a specific stage
     * @param stageId the stage ID
     * @return Stage object with full details
     */
    public Stage getStageInfo(int stageId) {
        Stage stage = null;
        
        String sql = "SELECT id, name, date, location, description, roadmap, total_laps, status, tblSeasonid "
                + "FROM tblstage "
                + "WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                stage = new Stage();
                stage.setId(rs.getInt("id"));
                stage.setName(rs.getString("name"));
                stage.setDate(rs.getDate("date"));
                stage.setLocation(rs.getString("location"));
                stage.setDescription(rs.getString("description"));
                stage.setRoadmap(rs.getString("roadmap"));
                stage.setTotalLaps(rs.getInt("total_laps"));
                stage.setStatus(rs.getBoolean("status"));
                stage.setSeasonId(rs.getInt("tblSeasonid"));
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return stage;
    }

    /**
     * Get all stages for admin management
     * @return list of all stages
     */
    public List<Stage> getAllStages() {
        List<Stage> stages = new ArrayList<>();
        
        String sql = "SELECT id, name, date, location, description, roadmap, total_laps, status, tblSeasonid "
                + "FROM tblstage "
                + "ORDER BY date DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Stage stage = new Stage();
                stage.setId(rs.getInt("id"));
                stage.setName(rs.getString("name"));
                stage.setDate(rs.getDate("date"));
                stage.setLocation(rs.getString("location"));
                stage.setDescription(rs.getString("description"));
                stage.setRoadmap(rs.getString("roadmap"));
                stage.setTotalLaps(rs.getInt("total_laps"));
                stage.setStatus(rs.getBoolean("status"));
                stage.setSeasonId(rs.getInt("tblSeasonid"));
                
                stages.add(stage);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return stages;
    }

    /**
     * Get all stages for a specific season
     * @param seasonId the season id
     * @return list of stages belonging to the given season
     */
    public List<Stage> getStagesBySeason(int seasonId) {
        List<Stage> stages = new ArrayList<>();

        String sql = "SELECT id, name, date, location, description, roadmap, total_laps, status, tblSeasonid "
                + "FROM tblstage "
                + "WHERE tblSeasonid = ? "
                + "ORDER BY date DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seasonId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Stage stage = new Stage();
                stage.setId(rs.getInt("id"));
                stage.setName(rs.getString("name"));
                stage.setDate(rs.getDate("date"));
                stage.setLocation(rs.getString("location"));
                stage.setDescription(rs.getString("description"));
                stage.setRoadmap(rs.getString("roadmap"));
                stage.setTotalLaps(rs.getInt("total_laps"));
                stage.setStatus(rs.getBoolean("status"));
                stage.setSeasonId(rs.getInt("tblSeasonid"));

                stages.add(stage);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return stages;
    }

    /**
     * Add a new stage to the database
     * @param stage the Stage object to add
     * @return true if successful, false otherwise
     */
    public boolean addStage(Stage stage) {
        String sql = "INSERT INTO tblstage (name, date, location, description, roadmap, total_laps, status, tblSeasonid) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, stage.getName());
            
            // Convert java.util.Date to java.sql.Date
            if (stage.getDate() != null) {
                ps.setDate(2, new java.sql.Date(stage.getDate().getTime()));
            } else {
                ps.setNull(2, java.sql.Types.DATE);
            }
            
            ps.setString(3, stage.getLocation());
            ps.setString(4, stage.getDescription());
            ps.setString(5, stage.getRoadmap());
            ps.setInt(6, stage.getTotalLaps());
            ps.setBoolean(7, stage.isStatus());
            ps.setInt(8, stage.getSeasonId());
            
            int result = ps.executeUpdate();
            ps.close();
            
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
