import java.sql.Connection;
import java.sql.DriverManager;

public class TestConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/";
        String user = "root";
        String password = "Ashish@#$2026"; // Put your password here

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println(" Connected to MySQL successfully!");
            conn.close();
        } catch (Exception e) {
            System.out.println(" Connection failed!");
            e.printStackTrace();
        }
    }
}