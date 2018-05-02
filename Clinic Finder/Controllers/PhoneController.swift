//
//  PhoneController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/1/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit
import Foundation

class PhoneController {
    
    class func openPhoneApp(withPhoneNumber phoneNumber: Int) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
