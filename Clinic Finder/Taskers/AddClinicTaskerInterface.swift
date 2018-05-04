//
//  AddClinicTaskerInterface.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/3/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Foundation

protocol AddClinicTaskerInterface {
    var delegate: AddClinicTaskerDelegate? { get set }
    func addClinic(_ clinic: Clinic)
}

protocol AddClinicTaskerDelegate {
    func didSucceedAddingClinic(_ tasker: AddClinicTaskerInterface)
    func didFaillAddingClinic(_ tasker: AddClinicTaskerInterface, error: Error)
}
