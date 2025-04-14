import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class AddPoliceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String policeName = request.getParameter("police_name");
        String ranks = request.getParameter("ranks");
        String station = request.getParameter("station");

        Connection con = null;
        PreparedStatement pst = null;

        try {
            // Database connection
            String url = "jdbc:mysql://localhost:3306/traffic_monitoring";
            String username = "root";  // Update with your username
            String password = "root";  // Update with your password
            con = DriverManager.getConnection(url, username, password);

            // SQL query to insert new officer
            String query = "INSERT INTO police (police_name, ranks, station) VALUES (?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, policeName);
                       pst.setString(2, ranks);
            pst.setString(3, station);

            // Execute the query
            int result = pst.executeUpdate();

            if (result > 0) {
                // Redirect to the police page after successful insertion
                response.sendRedirect("police.jsp");
            } else {
                response.getWriter().println("Error adding officer.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
