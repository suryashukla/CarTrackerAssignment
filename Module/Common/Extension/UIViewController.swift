//
//  UIViewController.swift
//  CarTracker
//
//  Created by surya shukla on 09/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showSpinner(onView: UIView) {
        let window = UIApplication.shared.connectedScenes.flatMap{ ($0 as? UIWindowScene)?.windows ?? []}.first{$0.isKeyWindow}
        let spinnerView = UIView.init(frame: window?.bounds ?? .zero)
        spinnerView.tag = 10101
        let loader = UIActivityIndicatorView.init(style: .large)
        loader.startAnimating()
        loader.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(loader)
            window?.addSubview(spinnerView)
        }
    }
    
    func removeSpinner() {
        let window = UIApplication.shared.connectedScenes.flatMap{ ($0 as? UIWindowScene)?.windows ?? []}.first{$0.isKeyWindow}
        
        DispatchQueue.main.async {
            for view in window?.subviews ?? [] {
                if view.tag == 10101 {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
