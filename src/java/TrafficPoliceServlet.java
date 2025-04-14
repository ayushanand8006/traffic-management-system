import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class TrafficPoliceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String badge = request.getParameter("badge_number");
        String contact = request.getParameter("contact");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");
            PreparedStatement ps = con.prepareStatement("INSERT INTO traffic_police (name, badge_number, contact) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, badge);
            ps.setString(3, contact);
            ps.executeUpdate();
            response.sendRedirect("police.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
