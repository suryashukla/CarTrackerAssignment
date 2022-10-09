//
//  UserListTableViewCell.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation
import UIKit

class UserListTableViewCell: UITableViewCell, TableCellGettable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func setUserData(_ user: UserList) {
        nameLabel.text = user.userName
        emailLabel.text = user.email
    }
    
}
