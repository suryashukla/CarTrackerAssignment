//
//  UserViewModel.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation

class UserViewModel {
    var serviceManager: ServiceManagerProtocol = ServiceManager.shared
    
    init(serviceManager: ServiceManagerProtocol = ServiceManager.shared) {
        self.serviceManager = serviceManager
    }
    
    func getUsers(_ completionHandler: @escaping([UserList]?, String?) -> Void) {
        serviceManager.getUserList { (response: Result<[UserList]?, NetworkError>) in
            switch response {
            case .success(let result):
                let users = result ?? []
                completionHandler(users, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
