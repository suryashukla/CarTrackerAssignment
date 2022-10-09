//
//  RequestManager.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation

extension ServiceManager: ServiceManagerProtocol {
  
    // MARK: VALIDATE  REQUEST
    func urlRequestWithValidation(urlPath: String, httpMethod: HTTPMethod) -> (URLRequest?, NetworkError?) {
        guard Reachability.isConnectedToNetwork() else {
            return (nil, NetworkError.badResponse(code: 501, description: "Can not connect to network! Please check your network/SIM and try again."))
        }
        guard let url = URL(string: urlPath) else {
            return (nil, NetworkError.badUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return (request, nil)
    }
   
    func getUserList(_ completion: @escaping (Result<[UserList]?, NetworkError>) -> Void) {
        let apiPath = APIPath.userList
        let requestData = urlRequestWithValidation(urlPath: apiPath, httpMethod: .get)
        guard let urlRequest = requestData.0 else {
            completion(Result.failure(requestData.1!))
            return
        }
        loadRequest(request: urlRequest, completion: completion)
    }
}
