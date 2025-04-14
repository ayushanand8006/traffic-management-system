import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class AddViolationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String vehicleNumber = request.getParameter("vehicle_number");
        String violationType = request.getParameter("violation_type");
        String penaltyStr = request.getParameter("penalty");
        String policeIdStr = request.getParameter("police_id");

        // Basic input validation
        if (vehicleNumber == null || violationType == null || penaltyStr == null || policeIdStr == null ||
            vehicleNumber.isEmpty() || violationType.isEmpty() || penaltyStr.isEmpty() || policeIdStr.isEmpty()) {
            out.println("Error: All fields are required.");
            return;
        }

        try {
            double penalty = Double.parseDouble(penaltyStr);
            int policeId = Integer.parseInt(policeIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

            // Check if the police_id exists in the police table
            String checkPoliceQuery = "SELECT COUNT(*) FROM police WHERE police_id = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkPoliceQuery);
            checkStmt.setInt(1, policeId);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int policeCount = rs.getInt(1);
            
            if (policeCount > 0) {
                // Proceed with inserting the violation if police_id is valid
                String sql = "INSERT INTO violations(vehicle_number, violation_type, penalty, police_id) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, vehicleNumber);
                ps.setString(2, violationType);
                ps.setDouble(3, penalty);
                ps.setInt(4, policeId);

                int rowsInserted = ps.executeUpdate();
                ps.close();

                if (rowsInserted > 0) {
                    response.sendRedirect("violations.jsp"); // Redirect to violations page
                } else {
                    out.println("Error: Violation not added. Please try again.");
                }
            } else {
                // Handle the case where police_id does not exist
                out.println("Error: Invalid Police ID. Please ensure the Police ID exists.");
            }

            con.close();

        } catch (NumberFormatException e) {
            out.println("Error: Penalty must be a number and Police ID must be an integer.");
        } catch (SQLException e) {
            out.println("SQL Error: " + e.getMessage());
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
