//
//  LocationManager.swift
//  MyWeather
//
//  Created by Nebula on 25.02.24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location
        manager.stopUpdatingLocation()
    }
}

extension LocationManager {
 
    func getSearchedLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placeMarks, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let placeMarks = placeMarks?[0] else {
                print("PlaceMark is nil")
                completion(nil)
                return
            }
            
            guard let location = placeMarks.location else {
                print("PlaceMark is nil")
                completion(nil)
                return
            }
            
            completion(location)
        }
    }
    
    
}
