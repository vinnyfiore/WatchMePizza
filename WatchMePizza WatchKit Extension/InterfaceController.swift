//
//  InterfaceController.swift
//  WatchMePizza WatchKit Extension
//
//  Created by Vincent Fiore on 2/24/15.
//  Copyright (c) 2015 Vinny Fiore Apps. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation
import MapKit


class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {
   
    let locationManager = CLLocationManager()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.locationManager.delegate=self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            }
            else {
                println("Error with data")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {

        self.locationManager.stopUpdatingLocation()

        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
  
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {        
        println("Error: " + error.localizedDescription)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
