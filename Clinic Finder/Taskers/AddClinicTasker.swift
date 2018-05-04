//
//  AddClinicTasker.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/3/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import FirebaseDatabase

class AddClinicTasker: AddClinicTaskerInterface {
    
    var ref = Database.database().reference().child("Pending Clinics")
    
    var delegate: AddClinicTaskerDelegate?
    
    func addClinic(_ clinic: Clinic) {
        print("testing")
    }
    
}
