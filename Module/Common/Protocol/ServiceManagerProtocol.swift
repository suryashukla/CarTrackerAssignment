//
//  ServiceManagerProtocol.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation

protocol ServiceManagerProtocol: AnyObject {
    func getUserList(_ completion: @escaping (Result<[UserList]?, NetworkError>) -> Void)
}
