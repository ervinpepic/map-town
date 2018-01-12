//
//  ViewController.swift
//  map-town
//
//  Created by Ervin on 1/11/18.
//  Copyright © 2018 Ervin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let authStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        configLocationServices()
        addDoubleTap()
     
    }

    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropThePin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }

    @IBAction func getLocationButton(_ sender: Any) {
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            centerMapOnCurrentUserLocation()
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    func centerMapOnCurrentUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0 , regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropThePin(sender: UITapGestureRecognizer) {
        
        clearPreviousPin()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DropPin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
        
        let coordinateReion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateReion, animated: true)
        
        
    }
    
    func clearPreviousPin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func configLocationServices() {
        if authStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnCurrentUserLocation()
    }
}
