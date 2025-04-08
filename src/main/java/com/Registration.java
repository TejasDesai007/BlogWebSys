package com;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;


public class Registration extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String error = "", success = "";

        if (username == null || email == null || password == null || confirmPassword == null ||
                username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {

            error = "All fields are required.";
        } else if (!password.equals(confirmPassword)) {
            error = "Passwords do not match.";
        } else {
            try {
                DBConnection db = new DBConnection();
                MongoDatabase database = db.getConnection();

                MongoCollection<Document> users = database.getCollection("User");

                // Check if email already exists
                Document existingUser = users.find(new Document("Email", email)).first();
                if (existingUser != null) {
                    error = "Email already registered.";
                } else {
                    Document newUser = new Document("Username", username)
                            .append("Email", email)
                            .append("PasswordHash", hashedPassword) // Consider hashing
                            .append("CreatedAt", new java.util.Date());

                    users.insertOne(newUser);
                    success = "Registration successful. You can now log in.";
                }

            } catch (Exception e) {
                error = "Registration failed: " + e.getMessage();
                e.printStackTrace();
            }
        }

        // Pass result back to JSP
        request.setAttribute("error", error);
        request.setAttribute("success", success);
        request.getRequestDispatcher("Register").forward(request, response);
    }
}
