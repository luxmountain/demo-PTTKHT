package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import model.Member;

public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    public boolean checkLogin(Member member) {
        boolean result = false;

        if (member.getUsername().contains("true") || member.getUsername().contains("=")
                || member.getPassword().contains("true") || member.getPassword().contains("=")) {
            return false;
        }

        String sql
                = "SELECT m.id, m.name, "
                + "       CASE "
                + "           WHEN a.tblMemberid IS NOT NULL THEN 'ADMIN' "
                + "           WHEN u.tblMemberid IS NOT NULL THEN 'USER' "
                + "           ELSE 'NONE' "
                + "       END AS role "
                + "FROM tblmember m "
                + "LEFT JOIN tbluser u ON m.id = u.tblMemberid "
                + "LEFT JOIN tbladmin a ON m.id = a.tblMemberid "
                + "WHERE m.username = ? AND m.password = ?";

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, member.getUsername());
            cs.setString(2, member.getPassword());
            ResultSet rs = cs.executeQuery();

            if (rs.next()) {
                member.setId(rs.getInt("id"));
                member.setName(rs.getString("name"));
                member.setRole(rs.getString("role"));
                result = true;
            }
            rs.close();
            cs.close();
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }

        return result;
    }

}
