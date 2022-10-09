//
//  RequestType.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public struct Request {
    let method: HTTPMethod
    let url: String
    let body: [String: Any]
    
    public init(method: HTTPMethod, url: String, body: [String: Any] = [:]) {
        self.method = method
        self.url = url
        self.body = body
    }
}
