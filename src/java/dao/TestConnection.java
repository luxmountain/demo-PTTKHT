package dao;

public class TestConnection {
    public static void main(String[] args) {
        DAO dao = new DAO();

        if (DAO.con != null) {
            System.out.println("KẾT NỐI THÀNH CÔNG!");
        } else {
            System.out.println("KẾT NỐI THẤT BẠI!");
        }
    }
}
