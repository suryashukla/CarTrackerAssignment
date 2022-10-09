//
//  LoginViewModel.swift
//  CarTracker
//
//  Created by surya shukla on 29/09/22.
//

import Foundation

class LoginViewModel {
    var users: [User] = []
    var databaseManager: DatabaseManager = DatabaseManager()
    
    func validateUser(with userName: String, password: String, completion: @escaping(Bool) -> Void) {
        let userID = Int.random(in: 0..<10)
        databaseManager.insertData(userInfo: User(userId: userID, userName: userName, password: password))
        let isSuccess = databaseManager.validateUser(userName: userName, password: password)
        isSuccess ? completion(true) : completion(false)
    }
}
