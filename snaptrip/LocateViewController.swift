//
//  LocateViewController.swift
//  snaptrip
//
//  Created by LH on 2/20/16.
//  Copyright © 2016 mrsata. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LocateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    // Declare the location manager
    var locationManager:CLLocationManager?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    
    var userLocation: CLLocation?
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var NSlatitude: NSString = ""
    var NSlongtitude: NSString = ""
    var latitude: Float!
    var longtitude: Float!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
                
        locManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                currentLocation = locManager.location
        }
        userLocation = mapView.userLocation.location!;
        NSlatitude = "\(userLocation!.coordinate.latitude)";
        NSlongtitude = "\(userLocation!.coordinate.longitude)";
        latitude = NSlatitude.floatValue
        longtitude = NSlongtitude.floatValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        switch(indexPath.row) {
        case(0):
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath) as! LabelCell
            return cell
        case(1):
            let cell = tableView.dequeueReusableCellWithIdentifier("PickerCell", forIndexPath: indexPath) as! PickerCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
            return cell
        }
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
