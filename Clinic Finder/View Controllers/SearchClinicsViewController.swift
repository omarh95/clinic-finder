//
//  SearchClinicsViewController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 3/24/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class SearchClinicsViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    fileprivate var loadClinicsTasker: LoadClinicsTasker!
    fileprivate let locationManager = CLLocationManager()
    
    fileprivate var selectedIndex = -1
    
    var allClinics: [Clinic] {
        get {
            return LoadClinicsButler.sharedInstance.allClinics
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showLoadingOverlay()
        self.navigationItem.title = "Clinic Finder"
        setupLocationManager()
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
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
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: UITableViewDataSource Methods
extension SearchClinicsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClinics.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClinicTableViewCell") as! ClinicTableViewCell
        cell.clinicNameLabel.text = allClinics[indexPath.row].name
        cell.clinicDistanceLabel.text = ".2 mi"
        cell.clinicServicesLabel.text = "first, second, third"
        return cell
    }
    
    //MARK: UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        selectedIndex = selectedRow
        let selectedClinic = allClinics[selectedRow]
        mapView.setCenter(selectedClinic.location, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            return 125
        } else {
            return 75
        }
    }
}

//MARK: LoadClinicsTaskerDelegate Methods
extension SearchClinicsViewController: LoadClinicsTaskerDelegate {
    func didSucceedLoadingAllClinics(_ tasker: LoadClinicsTasker) {
        setupMapView()
        tableView.reloadData()
        self.view.removeLoadingOverlay()
    }
    
    func didFailLoadingAllClinics(_ tasker: LoadClinicsTasker, error: Error!) {
        //display error message
    }
}

//MARK: MKMapViewDelegate Methods
extension SearchClinicsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
