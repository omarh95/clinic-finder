//
//  GetCoordinatesFromAddressStringTaskerInterface.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/8/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import CoreLocation

protocol GetCoordinatesFromAddressStringTaskerInterface: class {
    weak var delegate: GetCoordinatesFromAddressStringTaskerDelegate? { get set }
    func getCoordinatesFromAddressString(_ addressString: String)
}

protocol GetCoordinatesFromAddressStringTaskerDelegate: class {
    func didSucceedGettingCoordinatesFromAddressString(_ addressString: String, coordinates: CLLocationCoordinate2D)
    func didFailGettingCoordinatesFromAddressString(error: Error?)
}
