//
//  AddClinicViewController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/24/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Eureka
import UIKit
import CoreLocation

class AddClinicViewController: FormViewController {
    
    fileprivate lazy var addClinicTasker: AddClinicTaskerInterface = {
        let tasker = AddClinicTasker()
        tasker.delegate = self
        return tasker
    }()
    
    fileprivate lazy var getCoordinatesTasker: GetCoordinatesFromAddressStringTaskerInterface = {
        let tasker = GetCoordinatesFromAddressStringTasker()
        tasker.delegate = self
        return tasker
    }()
    
    private let clinicToBeAdded = Clinic()
    
    // The order in which the address string should be formed
    private let addressPattern = ["address_line_1",
                                  "city",
                                  "state",
                                  "zipcode"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        form
        +++ Section("Clinic Information")
            <<< TextRow() { row in
                row.tag = "clinic name"
                row.title = "Clinic Name"
                row.placeholder = "Enter name here"
                row.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }).onChange({ (row) in
                    self.clinicToBeAdded.name = row.value

                })
            <<< PhoneRow() {
                $0.tag = "clinic phone number"
                $0.title = "Clinic Phone Number"
                $0.placeholder = "e.g. 4042781234"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleExactLength(exactLength: 10, msg: "too long!"))
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }).onChange({ (row) in
                    self.clinicToBeAdded.phoneNumber = Int(row.value ?? "")
                })
        +++ Section("Location Information")
            <<< TextRow() { row in
                row.tag = "address_line_1"
                row.title = "Address Line 1"
                row.placeholder = "E.g. 123 Sesame St."
                row.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
            
            <<< TextRow() { row in
                row.tag = "city"
                row.title = "City"
                row.add(rule: RuleRequired())
                row.placeholder = "E.g. Atlanta"
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
            <<< TextRow() { row in
                row.tag = "state"
                row.title = "State"
                row.add(rule: RuleRequired())
                row.placeholder = "GA"
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
            <<< TextRow() { row in
                row.tag = "zipcode"
                row.title = "Zipcode"
                row.add(rule: RuleRequired())
                row.add(rule: RuleExactLength(exactLength: 5))
                row.placeholder = "E.g. 30308"
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Submit"
                row.disabled = Condition.function(Array(self.form.values().keys), { (form) -> Bool in
                    for row in form.allRows {
                        if !row.isValid {
                            return false
                        }
                    }
                    return true
                })
                row.onCellSelection({ (cell, row) in
                    guard !row.isDisabled else { return }
                    self.showAlert(withTitle: "Thanks!",
                                   withMessage: "We will review this submission and add it as soon as we can",
                                   withButtonTitle: "Ok")
                    self.view.showLoadingOverlay()
                    self.getCoordinatesTasker.getCoordinatesFromAddressString(self.getAddressString())
                })
            }
    }
    
    private func getAddressString() -> String {
        var addressString = ""
        let formDict = self.form.values()
        for key in addressPattern {
            if let stringToAppend = formDict[key] as? String {
                addressString.append(stringToAppend + ", ")
            }
        }
        let lastIndex = addressString.index(addressString.endIndex, offsetBy: -2)
        return addressString.substring(to: lastIndex)
    }

}

extension AddClinicViewController: AddClinicTaskerDelegate {
    func didSucceedAddingClinic(_ tasker: AddClinicTaskerInterface) {
        self.view.removeLoadingOverlay()
        self.tabBarController?.selectedIndex = 0
    }
    
    func didFaillAddingClinic(_ tasker: AddClinicTaskerInterface, error: Error) {
        self.view.removeLoadingOverlay()
    }
}

extension AddClinicViewController: GetCoordinatesFromAddressStringTaskerDelegate {
    func didSucceedGettingCoordinatesFromAddressString(_ addressString: String, coordinates: CLLocationCoordinate2D) {
        self.clinicToBeAdded.location = coordinates
        self.clinicToBeAdded.addressString = getAddressString()
        self.addClinicTasker.addClinic(self.clinicToBeAdded)
    }
    
    func didFailGettingCoordinatesFromAddressString(error: Error?) {
        // TODO: Handle error
        self.view.removeLoadingOverlay()
        self.tabBarController?.selectedIndex = 0
    }
}

