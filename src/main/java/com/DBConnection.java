package com;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class DBConnection {

    private static final String URI = "mongodb+srv://tejasdesai056:Tejas007@cluster0.p19fotu.mongodb.net/Blog?retryWrites=true&w=majority&appName=Cluster0";
    private static final String DATABASE_NAME = "Blog";

    private static MongoClient mongoClient = null;
    private static MongoDatabase database = null;

    public static MongoDatabase getConnection() {
        if (mongoClient == null) {
            try {
                mongoClient = MongoClients.create(URI);
                database = mongoClient.getDatabase(DATABASE_NAME);
                System.out.println("✅ MongoDB Atlas Connected to Blog database.");
            } catch (Exception ex) {
                System.out.println("❌ Exception While Connecting to MongoDB: " + ex.getMessage());
            }
        }
        return database;
    }

    public static void closeConnection() {
        if (mongoClient != null) {
            mongoClient.close();
            System.out.println("🛑 MongoDB connection closed.");
        }
    }
}
