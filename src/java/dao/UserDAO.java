package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

public class UserDAO extends DAO {

    public UserDAO() {
        super();
    }

    public User getUserInfo(int memberId) {
        User user = null;
        String sql = "SELECT m.id, m.username, m.name, m.password, m.dob, m.address, m.email, m.phonenumber "
                + "FROM tbluser u "
                + "INNER JOIN tblmember m ON u.tblMemberid = m.id "
                + "WHERE m.id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setDob(rs.getDate("dob"));
                user.setAddress(rs.getString("address"));
                user.setEmail(rs.getString("email"));
                user.setPhonenumber(rs.getString("phonenumber"));
                user.setRole("USER");
            }
            
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
