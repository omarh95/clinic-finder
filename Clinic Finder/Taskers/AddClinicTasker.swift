//
//  AddClinicTasker.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/3/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import FirebaseDatabase

class AddClinicTasker: AddClinicTaskerInterface {
    
    weak var delegate: AddClinicTaskerDelegate?
    
    var ref = Database.database().reference().child("Pending Clinics")
    
    func addClinic(_ clinic: Clinic) {
        guard let clinicDict = clinic.convertToDictionary() else { return }
        
        self.ref.child(clinic.name!).setValue(clinicDict)
        delegate?.didSucceedAddingClinic(self)
    }
    
}
