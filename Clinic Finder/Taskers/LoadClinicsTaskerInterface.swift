//
//  GetClinicsTaskerDelegate.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/25/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

protocol LoadClinicsTaskerInterface: class {
    var delegate: LoadClinicsTaskerDelegate! { get set }
    func getAllClinics()
}

protocol LoadClinicsTaskerDelegate: class {
    func didSucceedLoadingAllClinics(_ tasker: LoadClinicsTasker)
    func didFailLoadingAllClinics(_ tasker: LoadClinicsTasker, error: Error!)
}
