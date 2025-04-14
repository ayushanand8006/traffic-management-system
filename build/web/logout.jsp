<%@ page language="java" %>
<%
    session.invalidate(); // Ends the current session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
