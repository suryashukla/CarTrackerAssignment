//
//  URLResponse.swift
//  CarTracker
//
//  Created by surya shukla on 29/09/22.
//

import Foundation
import UIKit

extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}

