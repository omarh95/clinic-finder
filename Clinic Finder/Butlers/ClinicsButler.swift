//
//  ClinicsButler.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/25/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

class ClinicsButler {
    
    var allClinics = [Clinic]()
    
    var selectedClinic: Clinic?
    
    static let sharedInstance = ClinicsButler()
    private init() { }
    
}
