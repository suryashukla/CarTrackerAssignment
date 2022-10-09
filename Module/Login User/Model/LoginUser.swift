//
//  LoginUser.swift
//  CarTracker
//
//  Created by surya shukla on 05/10/22.
//

import Foundation

class User {
    var userId: Int = 0
    var userName: String = ""
    var password: String = ""
    
    init(userId: Int, userName: String, password: String) {
        self.userId = userId
        self.userName = userName
        self.password = password
    }
}
