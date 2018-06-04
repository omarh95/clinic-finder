//
//  GetClinicsTasker.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/25/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import FirebaseDatabase
import CoreLocation

class LoadClinicsTasker: LoadClinicsTaskerInterface {
    
    var delegate: LoadClinicsTaskerDelegate!
    var ref: DatabaseReference!

    func getAllClinics() {
        ref = Database.database().reference().child("Clinics")
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let allClinicData = snapshot.value as? [String: Any] else { return }
            for case let (clinicName, clinicData) as (String, [String: Any]) in allClinicData {
                guard let clinicLocationData = clinicData["Location"] as? [String: Double] else { return }
                let clinicCoordinates = CLLocationCoordinate2D(latitude: clinicLocationData["Lat"]!,
                                                               longitude: clinicLocationData["Long"]!)
                let clinicPhoneNumber = clinicData["Phone-Number"]! as? Int
                let clinicToAppend = Clinic(name: clinicName, location: clinicCoordinates, phoneNumber: clinicPhoneNumber!)
                ClinicsButler.sharedInstance.allClinics.append(clinicToAppend)
            }
            strongSelf.delegate.didSucceedLoadingAllClinics(strongSelf)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate.didFailLoadingAllClinics(strongSelf, error: error)
        }
    }

}

