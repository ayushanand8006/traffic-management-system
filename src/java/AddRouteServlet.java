import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class AddRouteServlet extends HttpServlet {

    // Handle GET request (e.g., user clicking on a link to this servlet)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Optionally, redirect to a form page or show a message
        response.sendRedirect("add_route.jsp");  // You can change this to any JSP page you want
    }

    // Handle POST request (form submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String route = request.getParameter("route_name");
        String source = request.getParameter("source");
        String dest = request.getParameter("destination");

        try {
            Class.forName("com.mysql.jdbc.Driver"); // Or com.mysql.cj.jdbc.Driver if using newer MySQL connector
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO routes (route_name, source, destination) VALUES (?, ?, ?)");
            ps.setString(1, route);
            ps.setString(2, source);
            ps.setString(3, dest);
            ps.executeUpdate();

            response.sendRedirect("routes.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
