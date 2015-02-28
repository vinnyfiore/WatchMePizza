//
//  ViewController.swift
//  WatchMePizza
//
//  Created by Vincent Fiore on 2/24/15.
//  Copyright (c) 2015 Vinny Fiore Apps. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationOne:CoreLocationController = CoreLocationController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "locationAvailable:",
            name: "LOCATION_AVAILABLE",
            object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "pizza"
        
        while (self.locationOne.locationManager.location==nil){
            sleep(1)
        }
        var locationCoordinates = locationOne.locationManager.location
       
        //println(locationCoordinates.coordinate.latitude)
        //println(locationCoordinates.coordinate.longitude)
        //println(locationCoordinates)

        
        
        var location = CLLocationCoordinate2D(
            latitude: locationCoordinates.coordinate.latitude,
            longitude: locationCoordinates.coordinate.longitude
        )
        
        var span = MKCoordinateSpanMake(0.5, 0.5)
        
        request.region = MKCoordinateRegion(center: location, span: span)
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({(response: MKLocalSearchResponse!,
            error: NSError!) in
            
            if error != nil {
                println("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                println("No matches found")
            } else {
                println("Matches found")
                
                for item in response.mapItems as [MKMapItem] {
                    println("Name = \(item.name)")
                    println("Phone = \(item.phoneNumber)")
                }
            }
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func locationAvailable(notification:NSNotification) -> Void {
        println("locationAvailable:")
        
        // Configure interface objects here.
    
            }
}



    
    



