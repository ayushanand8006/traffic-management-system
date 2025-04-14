package com.smarttraffic.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get existing session if exists
        if (session != null) {
            session.invalidate(); // Invalidate session
        }
        response.sendRedirect("login.jsp"); // Redirect to login
    }
}
