//
//  CLLocationCoordinate2D+DistanceCalculations.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/2/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    func distanceFromUserLocation() -> CLLocationDistance? {
        guard let currentUserLocation = LocationsButler.userCurrentLocation else { return nil }
        return distance(from: currentUserLocation.coordinate)
    }
    
    // distance in meters, as explained in CLLoactionDistance definition
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let destination = CLLocation(latitude:from.latitude,longitude:from.longitude)
        return CLLocation(latitude: latitude, longitude: longitude).distance(from: destination)
    }
    
}
