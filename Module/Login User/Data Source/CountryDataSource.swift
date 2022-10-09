//
//  CountryDataSource.swift
//  CarTracker
//
//  Created by surya shukla on 02/10/22.
//

import Foundation
import UIKit

protocol CountryDelegate: AnyObject {
    func countryAtIndex(_ country: Country)
}

class CountryDataSource: NSObject {
    var countries: [Country] = []
    var searchedCountry: [Country]  = []
    var searching = false
    weak var delegate: CountryDelegate?
    
}

extension CountryDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCountry.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var countryName = ""
        if searching {
            countryName =  searchedCountry[indexPath.row].flag + " " + searchedCountry[indexPath.row].name
        } else {
            countryName =  countries[indexPath.row].flag + " " + countries[indexPath.row].name
        }
        cell.textLabel?.text = countryName
        return cell
    }
}

extension CountryDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = searching ? searchedCountry[indexPath.row] : countries[indexPath.row]
        delegate?.countryAtIndex(country)
    }
}
