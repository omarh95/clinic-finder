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
        // Do any additional setup after loading the view, typically from a nib.
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
                strongSelf.setupMapView()
            }
        })
        
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Helper Methods
    private func setupMapView() {
        for clinic in clinics {
            let annotation = MKPointAnnotation()
            annotation.coordinate = clinic.location
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    //MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = "Alfarooq Clinic"
        
        return cell
    }
    
}

