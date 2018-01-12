//
//  ViewController.swift
//  map-town
//
//  Created by Ervin on 1/11/18.
//  Copyright © 2018 Ervin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
     
    }


    @IBAction func getLocationButton(_ sender: Any) {
    }
    
}


extension MapVC: MKMapViewDelegate {
    
}
