package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Admin;

public class AdminDAO extends DAO {

    public AdminDAO() {
        super();
    }

    public Admin getAdminInfo(int memberId) {
        Admin admin = null;
        String sql = "SELECT id, username, name, password, dob, address, email, phonenumber "
            + "FROM tblmember "
            + "WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setName(rs.getString("name"));
                admin.setPassword(rs.getString("password"));
                admin.setDob(rs.getDate("dob"));
                admin.setAddress(rs.getString("address"));
                admin.setEmail(rs.getString("email"));
                admin.setPhonenumber(rs.getString("phonenumber"));
                admin.setRole("ADMIN");
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return admin;
    }
}
