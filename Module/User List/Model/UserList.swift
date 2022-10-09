//
//  UserList.swift
//  CarTracker
//
//  Created by surya shukla on 29/09/22.
//

import Foundation

struct UserList: Codable {
    let userId: Int?
    let name: String?
    let userName: String?
    let email: String?
    let address: Address?
    let phoneNumber: String?
    let website: String?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name = "name"
        case userName = "username"
        case email = "email"
        case address = "address"
        case phoneNumber = "phone"
        case website = "website"
    }
    
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipCode: String?
    let geoLocation: GeoLocation?
    
    private enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipCode = "zipcode"
        case geoLocation = "geo"
    }
}

struct GeoLocation: Codable {
    let latitude: String?
    let longitude: String?
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable {
    let companyName: String?
    let catchPhrase: String?
    let companyType: String?
    
    private enum CodingKeys: String, CodingKey {
        case companyName = "name"
        case catchPhrase = "catchPhrase"
        case companyType = "bs"
    }
}
