package com;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class DBConnection {

    private MongoClient mongoClient;
    private MongoDatabase database;

    public MongoDatabase getConnection() {
        try {
            // Replace <password> with your actual MongoDB Atlas password
            String uri = "mongodb+srv://tejasdesai056:Tejas007@cluster0.p19fotu.mongodb.net/Blog?retryWrites=true&w=majority&appName=Cluster0";


            mongoClient = MongoClients.create(uri);
            database = mongoClient.getDatabase("Blog");

            System.out.println("✅ MongoDB Atlas Connected to Blog database.");
        } catch (Exception ex) {
            System.out.println("Exception While Connecting to MongoDB: " + ex.getMessage());
        }
        return database;
    }
}
