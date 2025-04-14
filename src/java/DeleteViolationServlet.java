import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class DeleteViolationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String violationId = request.getParameter("id");

        if (violationId != null && !violationId.isEmpty()) {
            try {
                // Load MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

                // Prepare SQL statement
                String query = "DELETE FROM violations WHERE violation_id = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(violationId));

                // Execute the query
                int result = ps.executeUpdate();

                // Check if deletion was successful
                if (result > 0) {
                    // Redirect to violations page after successful deletion
                    response.sendRedirect("violations.jsp");
                } else {
                    // Handle failure case where no record was deleted
                    response.getWriter().println("<h3>Error deleting violation: Record not found!</h3>");
                }

                // Close resources
                ps.close();
                con.close();

            } catch (Exception e) {
                // Log error and send error response
                e.printStackTrace();
                response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        } else {
            // Invalid or missing ID, redirect or show error message
            response.getWriter().println("<h3>Error: Missing or invalid violation ID</h3>");
        }
    }
}
