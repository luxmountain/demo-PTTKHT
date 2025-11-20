package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

import model.Member;

public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    public boolean checkLogin(Member member) {
        boolean ketQua = false;
        
        if (member.getUsername().contains("true") || member.getUsername().contains("=")
                || member.getPassword().contains("true") || member.getPassword().contains("=")) {
            return false;
        }
        
        String sql = "SELECT * FROM Member WHERE username = ? AND password = ?";
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, member.getUsername());
            cs.setString(2, member.getPassword());
            ResultSet rs = cs.executeQuery();

            if (rs.next()) {
                member.setId(rs.getInt("id"));
                member.setVaiTro(rs.getString("vaitro"));
                member.setHoTen(rs.getString("hoten"));
                ketQua = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ketQua = false;
        }
        return ketQua;
    }
}
