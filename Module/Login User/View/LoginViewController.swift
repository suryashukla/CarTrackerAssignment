//
//  LoginViewController.swift
//  CarTracker
//
//  Created by surya shukla on 29/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    lazy var loginViewModel: LoginViewModel = LoginViewModel()
    var countryName: String = ""
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextFiled.text = ""
        passwordTextFiled.text = ""
        countryName = ""
        setUpView()
    }
    
    // MARK: SetUp View
    private func setUpView() {
        containerView.layer.cornerRadius = 10.0
        countryButton.setTitle("Country", for: .normal)
        countryButton.setTitleColor(UIColor.lightGray, for: .normal)
        countryButton.contentHorizontalAlignment = .left
        countryButton.layer.cornerRadius = 5.0
        
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .leading
        configuration.contentInsets = .init(top: 0, leading: 10.0, bottom: 0, trailing: 10.0)
        countryButton.configuration = configuration

        userNameTextFiled.addPadding(padding: .equalSpacing(10))
        userNameTextFiled.layer.cornerRadius = 5
        
        passwordTextFiled.addPadding(padding: .equalSpacing(10))
        passwordTextFiled.layer.cornerRadius = 5

    }
    
    // MARK: Validate User
    private func validateUser() {
        if userNameTextFiled.text?.isEmpty ?? false {
            showAlert(messagetText: "Please enter user name")
            return
        }
        if passwordTextFiled.text?.isEmpty ?? false {
            showAlert(messagetText: "Please enter password")
            return
        }
        if countryName.isEmpty {
            showAlert(messagetText: "Please select country")
            return
        }
                
        loginViewModel.validateUser(with: userNameTextFiled.text ?? "", password: passwordTextFiled.text ?? "") { [weak self](isValid) in
            guard let self = self else { return }
            if isValid {
                let viewController = UserListViewController(nibName: "UserListViewController", bundle: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                self.showAlert(messagetText: "Please enter valid user name and password")
            }
        }
    }
    
    private func showAlert(messagetText: String) {
        let alert = UIAlertController(title: "CarTracker!", message: messagetText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
            
    // MARK: Button Action
    @IBAction func loginButtonAction(_ id: UIButton) {
        validateUser()
        self.view.endEditing(false)
    }
    
    @IBAction func countryButtonAction(_ id: UIButton) {
        self.view.endEditing(false)
        let viewController = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
        viewController.modalPresentationStyle = .popover
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: Country Delegate
extension LoginViewController: UserCountryDelegate {
    func selectedCountry(_ country: Country) {
        countryName = country.flag + " " + country.name
        countryButton.setTitle(countryName, for: .normal)
        countryButton.setTitleColor(UIColor.black, for: .normal)
    }

}

// MARK: TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

