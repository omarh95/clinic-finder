//
//  AddClinicViewController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/24/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Eureka
import UIKit

class AddClinicViewController: FormViewController {
    
    let clinicToBeAdded = Clinic()

    override func viewDidLoad() {
        super.viewDidLoad()
        form
        +++ Section("Clinic Information")
            <<< TextRow() { row in
                row.title = "Clinic Name"
                row.placeholder = "Enter name here"
            }
            <<< PhoneRow() {
                $0.title = "Clinic Phone Number"
                $0.placeholder = "e.g. 4042781234"
            }
        +++ Section("Location Information")
            <<< TextRow() { row in
                row.title = "Address Line 1"
                row.placeholder = "E.g. 123 Sesame St."
            }
            <<< TextRow() { row in
                row.title = "Address Line 2"
                row.placeholder = "E.g. Suite 123"
            }
            <<< TextRow() { row in
                row.title = "City"
                row.placeholder = "E.g. Atlanta"
            }
            <<< TextRow() { row in
                row.title = "Zipcode"
                row.placeholder = "E.g. 30308"
            }
        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Submit"
                row.onCellSelection({ (cell, row) in
                    self.showAlert(withTitle: "Thanks!",
                                   withMessage: "We will review this submission and add it as soon as we can",
                                   withButtonTitle: "Ok")
                })
            }
    }

}

