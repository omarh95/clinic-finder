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
                row.title = "Clinic Name"
                row.placeholder = "Enter name here"
                }.onChange({ (row) in
                    self.clinicToBeAdded.name = row.value
                })
            <<< PhoneRow() {
                $0.title = "Clinic Phone Number"
                $0.placeholder = "e.g. 4042781234"
                }.onChange({ (row) in
                    self.clinicToBeAdded.phoneNumber = Int(row.value!)
                })
        +++ Section("Location Information")
            <<< TextRow() { row in
                row.tag = "address_line_1"
                row.title = "Address Line 1"
                row.placeholder = "E.g. 123 Sesame St."
            }
            <<< TextRow() { row in
                row.tag = "city"
                row.title = "City"
                row.placeholder = "E.g. Atlanta"
            }
            <<< TextRow() { row in
                row.tag = "state"
                row.title = "State"
                row.placeholder = "GA"
            }
            <<< TextRow() { row in
                row.tag = "zipcode"
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
        self.addClinicTasker.addClinic(self.clinicToBeAdded)
    }
    
    func didFailGettingCoordinatesFromAddressString(error: Error?) {
        // TODO: Handle error
        print(error)
    }
}

