//
//  Clinic.swift
//  
//
//  Created by Hayek, Omar on 3/24/18.
//

import CoreLocation

class Clinic {
    
    let name: String!
    let location: CLLocationCoordinate2D!
    let phoneNumber: Int!
    
    convenience init() {
        self.init(name: "", location: CLLocationCoordinate2D(), phoneNumber: 0)
    }
    
    init(name: String, location: CLLocationCoordinate2D, phoneNumber: Int) {
        self.name = name
        self.location = location
        self.phoneNumber = phoneNumber
    }
    
}
