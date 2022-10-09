//
//  APIConstants.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation

struct Configuration {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
}

struct APIPath {
    static let userList = "\(Configuration.baseURL)users"
}
