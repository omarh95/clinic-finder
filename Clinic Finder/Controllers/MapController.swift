//
//  MapController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/1/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import Foundation
import MapKit

class MapController {
    
    class func openMap(forLocation location: CLLocationCoordinate2D, andName name: String? = nil) {
        let latitude = location.latitude
        let longitude = location.longitude
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name ?? ""
        mapItem.openInMaps(launchOptions: options)
    }
    
}
