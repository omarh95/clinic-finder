//
//  FirstViewController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/24/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoadClinicsTaskerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    var loadClinicsTasker: LoadClinicsTasker!
    var allClinics: [Clinic] {
        get {
            return LoadClinicsButler.sharedInstance.allClinics
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClinicsTasker = LoadClinicsTasker()
        loadClinicsTasker.delegate = self
        setupTableView()
        loadClinicsTasker.getAllClinics()
    }

    //MARK: Helper Methods
    private func setupMapView() {
        for clinic in allClinics {
            let annotation = MKPointAnnotation()
            annotation.coordinate = clinic.location
            mapView.addAnnotation(annotation)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    //MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClinics.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell.textLabel?.text = allClinics[indexPath.row].name
        return cell
    }
    
    //MARK: LoadClinicsTaskerDelegate Methods
    func didSucceedLoadingAllClinics(_ tasker: LoadClinicsTasker) {
        setupMapView()
        tableView.reloadData()
    }
    func didFailLoadingAllClinics(_ tasker: LoadClinicsTasker, error: Error!) {
        //display error message
    }
    
}

