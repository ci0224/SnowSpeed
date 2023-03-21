//
//  LocationManager.swift
//  SnowSpeed
//
//  Created by 黄熙 on 3/13/23.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var velocity: String = "?" {
        willSet { objectWillChange.send() }
    }
    @Published var cityName: String = "UNKNOWN CITY"{
        willSet { objectWillChange.send() }
    }
        
    override init() {
        super.init()
            
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startUpdatingLocation()
    }
}
    
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        var s: Double = 3.6 * location.speed
        if s < 0 {
            s = 0
        }
        self.velocity = String(format: "%0.2f", s)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            self.cityName = placemark.locality ?? ""
        }
    }
}

