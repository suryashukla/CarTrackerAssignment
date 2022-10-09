//
//  CountryListViewController.swift
//  CarTracker
//
//  Created by surya shukla on 02/10/22.
//

import Foundation
import UIKit

protocol UserCountryDelegate: AnyObject {
    func selectedCountry(_ country: Country)
}

class CountryListViewController: UIViewController {
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countryViewModel: CountryViewModel = CountryViewModel()
    var countryDataSource: CountryDataSource = CountryDataSource()
    weak var delegate: UserCountryDelegate?
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        countryTableView.dataSource = countryDataSource
        countryTableView.delegate = countryDataSource
        countryDataSource.delegate = self
        searchBar.delegate = self
        
        // Change TextField Color
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.black
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = UIColor.systemGray5
        
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .darkGray
        
        fetchCountries()

    }
    
    private func fetchCountries() {
        countryDataSource.countries = countryViewModel.countries
        countryTableView.reloadData()
    }
}

extension CountryListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countryDataSource.searchedCountry = countryDataSource.countries.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        countryDataSource.searching = true
        countryTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        countryDataSource.searching = false
        searchBar.text = ""
        countryTableView.reloadData()
    }
}

extension CountryListViewController: CountryDelegate {
    func countryAtIndex(_ country: Country) {
        self.dismiss(animated: true) {
            self.delegate?.selectedCountry(country)
        }
    }
}
