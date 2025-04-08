package com;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.conversions.Bson;

import static com.mongodb.client.model.Filters.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("txtUserNm");
        String password = request.getParameter("txtPassword");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            DBConnection dbConn = new DBConnection();
            MongoDatabase database = dbConn.getConnection();

            MongoCollection<Document> usersCollection = database.getCollection("Users");

            // BINARY comparison: exact match (case-sensitive)
            Bson filter = and(eq("username", username), eq("passwordHash", password));
            Document userDoc = usersCollection.find(filter).first();

            if (userDoc != null) {
                HttpSession session = request.getSession();
                session.setAttribute("UserId", userDoc.getObjectId("_id").toString());
                session.setAttribute("Username", userDoc.getString("username"));

                out.println("UserID: " + userDoc.getObjectId("_id").toString() + "<br>");
                out.println("Username: " + userDoc.getString("username"));
            } else {
                response.sendRedirect("Login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}
