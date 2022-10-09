//
//  DatabaseManager.swift
//  CarTracker
//
//  Created by surya shukla on 05/10/22.
//

import Foundation
import SQLite3

class DatabaseManager {
    
    static let databasePath: String = "carTracker.sqlite"
    var database: OpaquePointer?
    
    init() {
        database = openDatabase()
        createTable()
    }
    
    // MARK: Open Database
    private func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(DatabaseManager.databasePath)
        var database: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
            print("Error to Open Database")
            return nil
        } else {
            print("Database connection successfully opened at path: \(DatabaseManager.databasePath)")
            print("Database connection successfully opened at path: \(fileURL.path)")
            return database
        }
    }
    
    // MARK: CREATE TABLE
    private func createTable() {
        let queryStatement = "CREATE TABLE IF NOT EXISTS user(userId INTEGER PRIMARY KEY, userName TEXT, password TEXT)"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("user table has been created")
            } else {
                print("user table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    // MARK: INSERT DATA
    func insertData(userInfo: User) {
        let users = readData()
        if !users.isEmpty {
            return
        }
        
        let insertQueryStatement = "INSERT INTO user(userId, userName, password) VALUES(?, ?, ?)"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, insertQueryStatement, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(userInfo.userId))
            sqlite3_bind_text(insertStatement, 2, (userInfo.userName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (userInfo.password as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Record Successfully Inserted")
            } else {
                print("Record Could not Inserted")
            }
        } else {
            print("INSERT statement could not be prepared")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    // MARK: Validate User from DB
    func validateUser(userName: String, password: String) -> Bool  {
        let queryStatementString = "SELECT * FROM user WHERE userName = '" + userName + "' AND password = '" + password + "'"
        var queryStatement: OpaquePointer? = nil
        var dbUserName: String = ""
        var dbPassword: String = ""
        
        if sqlite3_prepare_v2(database, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                guard let name = sqlite3_column_text(queryStatement, 1), let pwd = sqlite3_column_text(queryStatement, 2) else {
                    print("Query statement nil")
                    return false
                }
                dbUserName = String(cString: name)
                dbPassword = String(cString: pwd)
            }
            
        } else {
            print("No Data Found")
        }
        sqlite3_finalize(queryStatement)
        return (dbUserName == userName && dbPassword == password ) ? true : false
    }
    
    
    // MARK: READ DATA
    func readData() -> [User] {
        let queryStatementString = "SELECT * FROM user"
        var queryStatement: OpaquePointer? = nil
        var user: [User] = []
        
        if sqlite3_prepare_v2(database, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let userID = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                user.append(User(userId: Int(userID), userName: name, password: password))
            }
        }
        sqlite3_finalize(queryStatement)
        return user
    }
}
