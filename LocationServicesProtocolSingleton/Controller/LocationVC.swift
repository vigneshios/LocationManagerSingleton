//
//  LocationVC.swift
//  LocationServicesProtocolSingleton
//
//  Created by Apple on 17/04/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit
import CoreLocation

class LocationVC: UIViewController, CustomLocationServiceDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Location services with a singleton and protocol oriented approach")
        LocationService.instance.startUpdatingLocation()
        LocationService.instance.delegate = self
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        print(" *************** Current Location = \(currentLocation) ***************")
    }
    
    func tracingLocationDidFailWithError(error: Error) {
        print(" ####### Error = \(error)")
    }
    

    
}
