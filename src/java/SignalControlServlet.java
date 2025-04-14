package com.traffic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signalControl")
public class SignalControlServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int greenTime = Integer.parseInt(request.getParameter("greenTime"));
        int yellowTime = Integer.parseInt(request.getParameter("yellowTime"));
        int redTime = Integer.parseInt(request.getParameter("redTime"));

        updateSignalTimes(greenTime, yellowTime, redTime);
        response.sendRedirect("dashboard.jsp");
    }

    private void updateSignalTimes(int green, int yellow, int red) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/traffic_management", "root", "root");

            String sql = "UPDATE traffic_signals SET green_time = ?, yellow_time = ?, red_time = ? WHERE location = 'Main Junction'";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, green);
            stmt.setInt(2, yellow);
            stmt.setInt(3, red);
            stmt.executeUpdate();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
