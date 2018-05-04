//
//  UIViewController+Alerts.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/3/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String, withMessage message: String, withButtonTitle buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
