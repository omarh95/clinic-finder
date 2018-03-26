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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoadClinicsTaskerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    var loadClinicsTasker: LoadClinicsTasker!
    let locationManager = CLLocationManager()
    var allClinics: [Clinic] {
        get {
            return LoadClinicsButler.sharedInstance.allClinics
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        loadClinicsTasker = LoadClinicsTasker()
        loadClinicsTasker.delegate = self
        setupTableView()
        loadClinicsTasker.getAllClinics()
    }

    //MARK: Helper Methods
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    private func setupMapView() {
        mapView.showsUserLocation = true
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

    //MARK: UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        let selectedClinic = allClinics[selectedRow]
        mapView.setCenter(selectedClinic.location, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    //MARK: MKMapViewDelegate Methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
        return nil
    }
}

