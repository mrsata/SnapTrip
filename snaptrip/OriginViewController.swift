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
    
    var locManager = CLLocationManager()
    var userLocation: CLLocation?
    var latitude: Double!
    var longitude: Double!
    let regionRadius: CLLocationDistance = 500

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locManager.distanceFilter = 50; //meters
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()

        // Check if it is denied
        if (CLLocationManager.authorizationStatus() == .Denied) {
            print("Authorization denied!");
            userLocation = CLLocation(latitude: 40.11428435, longitude: -88.22459354)
        }
        // Check if it is authorized
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                userLocation = locManager.location
        }
        
        centerMapOnLocation(userLocation!)
        
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
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func locationManager(locManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.count > 0) {
            for loc in locations {
                print("Location: \(loc)")
            }
        }
        print("The numbers in locations: \(locations.count)");
        latitude = locations[locations.count-1].coordinate.latitude
        longitude = locations[locations.count-1].coordinate.longitude
        userLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(userLocation!)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("LocationManager failed!")
    }

}
