//
//  CountryViewModel.swift
//  CarTracker
//
//  Created by surya shukla on 02/10/22.
//

import Foundation

class CountryViewModel {
    
    var countries: [Country] {
        var countryList: [Country] = []
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let countryName = NSLocale(localeIdentifier: "en").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            let countryFlag = countryFlag(country: code)
            countryList.append(Country(name: countryName, flag: countryFlag))
        }
        return countryList
    }
        
    // MARK: Add Flag Emoji
    func countryFlag(country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
