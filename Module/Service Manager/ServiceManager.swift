//
//  ServiceManager.swift
//  CarTracker
//
//  Created by surya shukla on 29/09/22.
//

import Foundation

public enum NetworkError: Error {
    case noInternetError
    case domainError
    case decodingError
    case badUrl
    case business
    case badResponse(code: Int?, description: String?)
    case badAllErrorResponse(code: Int?, description: String?, errorCode: Int?)
}

public class ServiceManager {
    public static let shared = ServiceManager()
    let urlSession = URLSession(configuration: .ephemeral)
    
    public func loadRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                completion(.failure(.noInternetError))
            }
            return
        }
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                DispatchQueue.main.async {
                    completion(.failure(.domainError))
                }
                return
            } else {
                if let response = response, let data = data, !response.isSuccess {
                    do {
                        let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        let error = NetworkError.badAllErrorResponse(code: response.httpStatusCode, description: result.error?.info, errorCode: result.error?.code)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.decodingError))
                        }
                        return
                    }
                }
                
                if let responseData = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: responseData)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.decodingError))
                        }
                    }
                }
            }
        }.resume()
    }
}

// MARK: ERROR RESPONSE
struct ErrorResponse: Codable {
    let success: Bool?
    let error: Error?

    struct Error: Codable {
        let code: Int?
        let type: String?
        let info: String?
    }
}
