//
//  UserListViewController.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation
import UIKit

class UserListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var userListTableView: UITableView!
    private lazy var userDataSource: UserDataSource  = UserDataSource()
    var userViewModel: UserViewModel = UserViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        userListTableView.dataSource = userDataSource
        userListTableView.delegate = userDataSource
        userDataSource.delegate = self
        setUpView()
    }
    
    private func setUpView() {
        registerCell()
        fetchUser()
    }
    
    private func registerCell() {
        userDataSource.registerCell(tableView: userListTableView)
    }
    
    // MARK: Fetch User
    private func fetchUser() {
        showSpinner(onView: self.view)
        userViewModel.getUsers { [weak self](userResponse, resMessage) in
            guard let self = self else {return}
            self.removeSpinner()
            if let userResponse = userResponse {
                self.userDataSource.users = userResponse
                self.userListTableView.reloadData()
            }
        }
    }
}

extension UserListViewController: UserDelegate {
    func showUserDetailAtIndex(_ user: UserList) {
        let viewController = UserLocationViewController(nibName: "UserLocationViewController", bundle: nil)
        viewController.user = user
        navigationController?.pushViewController(viewController, animated: true)
    }
}
