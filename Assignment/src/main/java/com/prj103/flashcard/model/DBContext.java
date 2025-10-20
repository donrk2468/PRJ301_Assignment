package com.prj103.flashcard.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    public Connection connection;
    public DBContext()
    {
        try {
            //Change the username password and url to connect your own database
            String username = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=flashcard_db;encrypt=true;trustServerCertificate=true;";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("DBContext: connected = " + (connection != null));

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
