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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    var clinics = [Clinic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let strongSelf = self else { return }
            guard let allClinicData = snapshot.value as? [String: Any] else { return }
            for case let (clinicName, clinicData) as (String, [String: Any]) in allClinicData {
                guard let clinicLocationData = clinicData["Location"] as? [String: Double] else { return }
                let clinicCoordinates = CLLocationCoordinate2D(latitude: clinicLocationData["Lat"]!,
                                                               longitude: clinicLocationData["Long"]!)
                strongSelf.clinics.append(Clinic(name: clinicName, location: clinicCoordinates))
                print(clinicData)
            }
            strongSelf.setupMapView()
            strongSelf.tableView.reloadData()
        })
        
        
    }

    //MARK: Helper Methods
    private func setupMapView() {
        for clinic in clinics {
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
        return clinics.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell.textLabel?.text = clinics[indexPath.row].name
        return cell
    }
    
}

