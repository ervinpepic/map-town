//
//  DropPin.swift
//  map-town
//
//  Created by Ervin on 12/01/2018.
//  Copyright © 2018 Ervin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DropPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        
        super.init()
    }

}
