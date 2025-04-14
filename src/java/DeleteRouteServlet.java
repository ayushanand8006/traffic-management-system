import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;

// URL pattern for this servlet
@WebServlet("/DeleteRouteServlet")
public class DeleteRouteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get route_id from request
        String routeId = request.getParameter("route_id");

        // Validate route_id
        if (routeId == null || routeId.trim().isEmpty()) {
            out.println("❌ Error: route_id is missing or invalid.");
            return;
        }

        try {
            int id = Integer.parseInt(routeId); // Convert to integer

            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // DB connection
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

            // SQL delete query
            PreparedStatement ps = con.prepareStatement("DELETE FROM routes WHERE route_id = ?");
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Success — redirect to view page
                response.sendRedirect("view_routes.jsp");
            } else {
                out.println("⚠️ Route not found or already deleted.");
            }

            // Close connection
            con.close();

        } catch (NumberFormatException e) {
            out.println("❌ Error: route_id must be a number.");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("❌ Error: " + e.getMessage());
        }
    }

    // Handle POST as GET
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
