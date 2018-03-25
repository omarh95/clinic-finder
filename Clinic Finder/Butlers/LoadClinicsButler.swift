//
//  LoadClinicsButler.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/25/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

class LoadClinicsButler {
    
    var allClinics = [Clinic]()
    
    static let sharedInstance = LoadClinicsButler()
    private init() { }
    
}
