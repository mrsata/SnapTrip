//
//  OriginViewController.swift
//  SnapTrip
//
//  Created by LH on 2/20/16.
//  Copyright © 2016 mrsata. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OriginViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager?
    var locations:[CLLocation]?
    
    var userLocation: CLLocation?
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var NSlatitude: NSString = ""
    var NSlongtitude: NSString = ""
    var latitude: Float!
    var longtitude: Float!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.distanceFilter = 50; //meters
        locationManager?.startUpdatingLocation()
        locationManager?.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view.
        if (CLLocationManager.authorizationStatus() == .Denied) {
            print("Authorization denied!");
            // Check if it is denied
        }
        
        let initialLocation = locations![locations!.count - 1]
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.count > 0) {
            for loc in locations {
                print("Location: \(loc)")
            }
            
            // print the last one only
        }
        print("The numbers in locations: \(locations.count)");
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("LocationManager failed!")
    }

}
