//
//  LocateViewController.swift
//  snaptrip
//
//  Created by LH on 2/20/16.
//  Copyright © 2016 mrsata. All rights reserved.
//

import UIKit
import MapKit

class LocateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    

    
    
}