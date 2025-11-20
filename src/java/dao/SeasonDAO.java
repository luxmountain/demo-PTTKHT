package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Season;

public class SeasonDAO extends DAO {

    public SeasonDAO() {
        super();
    }

    /**
     * Get all seasons ordered by year descending
     * @return list of seasons
     */
    public List<Season> getAllSeasons() {
        List<Season> seasons = new ArrayList<>();
        
        String sql = "SELECT id, name, year, totalpoints, startdate, enddate "
                + "FROM tblseason "
                + "ORDER BY year DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Season season = new Season();
                season.setId(rs.getInt("id"));
                season.setName(rs.getString("name"));
                season.setYear(rs.getInt("year"));
                season.setStartdate(rs.getDate("startdate"));
                season.setEnddate(rs.getDate("enddate"));
                
                seasons.add(season);
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return seasons;
    }

    /**
     * Get season by ID
     * @param seasonId the season ID
     * @return Season object
     */
    public Season getSeasonById(int seasonId) {
        Season season = null;
        
        String sql = "SELECT id, name, year, totalpoints, startdate, enddate "
                + "FROM tblseason WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, seasonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                season = new Season();
                season.setId(rs.getInt("id"));
                season.setName(rs.getString("name"));
                season.setYear(rs.getInt("year"));
                season.setStartdate(rs.getDate("startdate"));
                season.setEnddate(rs.getDate("enddate"));
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return season;
    }

    /**
     * Get season by year
     * @param year the year
     * @return Season object
     */
    public Season getSeasonByYear(int year) {
        Season season = null;
        
        String sql = "SELECT id, name, year, totalpoints, startdate, enddate "
                + "FROM tblseason WHERE year = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                season = new Season();
                season.setId(rs.getInt("id"));
                season.setName(rs.getString("name"));
                season.setYear(rs.getInt("year"));
                season.setStartdate(rs.getDate("startdate"));
                season.setEnddate(rs.getDate("enddate"));
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return season;
    }
}
