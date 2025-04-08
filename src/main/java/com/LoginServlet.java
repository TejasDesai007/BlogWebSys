package com;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("txtUserNm");
        String password = request.getParameter("txtPassword");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/yourdbname", "root", "yourpassword");

            PreparedStatement stmt = con.prepareStatement(
                    "SELECT UserId, Username FROM users WHERE BINARY Username=? AND BINARY PasswordHash=?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("UserId", rs.getString("UserId"));
                session.setAttribute("Username", rs.getString("Username"));
                PrintWriter out = response.getWriter();
                out.println(rs.getString("UserId"));
                out.println(rs.getString("Username"));
            } else {
                response.sendRedirect("Login.jsp?error=1");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
