import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class RouteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = "jdbc:mysql://localhost:3306/traffic_monitoring";
        String user = "root";
        String pass = "root";

        try {
            // Establish the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            // Add route
            if ("add".equals(action)) {
                String name = request.getParameter("route_name");
                String source = request.getParameter("source");
                String dest = request.getParameter("destination");

                PreparedStatement pst = con.prepareStatement("INSERT INTO routes (route_name, source, destination) VALUES (?, ?, ?)");
                pst.setString(1, name);
                pst.setString(2, source);
                pst.setString(3, dest);
                pst.executeUpdate();
                response.sendRedirect("view_routes.jsp");

            // Update route
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("route_id"));
                String name = request.getParameter("route_name");
                String source = request.getParameter("source");
                String dest = request.getParameter("destination");

                PreparedStatement pst = con.prepareStatement("UPDATE routes SET route_name=?, source=?, destination=? WHERE route_id=?");
                pst.setString(1, name);
                pst.setString(2, source);
                pst.setString(3, dest);
                pst.setInt(4, id);
                pst.executeUpdate();
                response.sendRedirect("view_routes.jsp");

            // Delete route
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement pst = con.prepareStatement("DELETE FROM routes WHERE route_id=?");
                pst.setInt(1, id);
                pst.executeUpdate();
                response.sendRedirect("view_routes.jsp");  // Redirect after deleting
            }

            con.close();  // Close the database connection
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database operation failed");
        }
    }
}
