//
//  LocationService.swift
//  LocationServicesProtocolSingleton
//
//  Created by Apple on 17/04/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import Foundation
import CoreLocation


protocol CustomLocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}


class LocationService: NSObject, CLLocationManagerDelegate {
    static let instance = LocationService()
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: CustomLocationServiceDelegate?
    
    override init() {
         super.init()
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {return}
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.lastLocation = location
        updateLocation(currentLocation: location)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error)
    }
    
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {return}
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        guard let delegate = self.delegate else {return}
        delegate.tracingLocationDidFailWithError(error: error)
    }
}
