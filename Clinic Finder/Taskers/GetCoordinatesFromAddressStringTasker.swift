//
//  GetCoordinatesFromAddressStringTasker.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/8/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Foundation
import CoreLocation

class GetCoordinatesFromAddressStringTasker: GetCoordinatesFromAddressStringTaskerInterface {
    
    var delegate: GetCoordinatesFromAddressStringTaskerDelegate?
    
    func getCoordinatesFromAddressString(_ addressString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                strongSelf.delegate?.didFailGettingCoordinatesFromAddressString(error: error)
                return
            }
            strongSelf.delegate?.didSucceedGettingCoordinatesFromAddressString(addressString, coordinates: location.coordinate)
        }
    }
    
}
