//
//  CoreLocationController.swift
//  WatchMePizza
//
//  Created by Vincent Fiore on 2/26/15.
//  Copyright (c) 2015 Vinny Fiore Apps. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationController : NSObject, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            break
            
        case .AuthorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            break
            
        default:
            break
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) -> CLLocation {
        
        //println("Running locationManager")
        
        
        if (locations.last?.timestamp!.timeIntervalSinceNow > -100){
            locationManager.stopUpdatingLocation()
        }
        let location = locations.last as CLLocation
        
        
        
        
        
        println("Location found is:  \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        return location
        
        
        
    }
    
}