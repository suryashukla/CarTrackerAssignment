//
//  UserDataSource.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation
import UIKit

protocol UserDelegate: AnyObject {
    func showUserDetailAtIndex(_ user: UserList)
}

class UserDataSource: NSObject {
    var users: [UserList] = []
    weak var delegate: UserDelegate?
    
    // MARK: Registering Cell
    func registerCell(tableView: UITableView) {
        tableView.register(UINib.init(nibName: UserListTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: UserListTableViewCell.reuseIdentifier)
        let nib = UINib(nibName: UserListTableViewCell.xibName, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: UserListTableViewCell.reuseIdentifier)
    }
}

extension UserDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reuseIdentifier, for: indexPath) as? UserListTableViewCell else {
            fatalError("Unable to load UserList Cell")
        }
         let user = users[indexPath.row]
         cell.setUserData(user)
         return cell
    }
}

extension UserDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.showUserDetailAtIndex(user)
    }
}
