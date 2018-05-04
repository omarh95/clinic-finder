//
//  Clinic.swift
//  
//
//  Created by Hayek, Omar on 3/24/18.
//

import CoreLocation

class Clinic {
    
    var name: String?
    var location: CLLocationCoordinate2D?
    var phoneNumber: Int?
    
    convenience init() {
        self.init(name: nil, location: nil, phoneNumber: nil)
    }
    
    init(name: String?, location: CLLocationCoordinate2D?, phoneNumber: Int?) {
        self.name = name
        self.location = location
        self.phoneNumber = phoneNumber
    }
    
    func convertToDictionary() -> Dictionary<String, Any>? {
        guard let clinicName = self.name else { return nil }
        guard let clinicLocation = self.location else { return nil}
        guard let clinicPhoneNumber = self.phoneNumber else { return nil }
        let dictToReturn: [String : Any] = ["name": clinicName,
                                            "location": ["lat": clinicLocation.latitude, "long": clinicLocation.longitude],
                                            "phoneNumber": clinicPhoneNumber]
        return dictToReturn
    }
    
}
