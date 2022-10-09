//
//  CellGettableProtocol.swift
//  CarTracker
//
//  Created by surya shukla on 30/09/22.
//

import Foundation
import UIKit

public protocol TableCellGettable {
    static var reuseIdentifier: String { get }
    static var xibName: String { get }
}

public extension TableCellGettable where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self.classForCoder())
    }
    
    static var xibName: String {
        return String(describing: self.classForCoder())
    }
}
