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
    
    init(name: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
    }
    
}
