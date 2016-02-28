//
//  CityViewController.swift
//  snaptrip
//
//  Created by LH on 2/20/16.
//  Copyright © 2016 mrsata. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var citiesTableView: UITableView!
    var distance: Int?
    var places: NSDictionary?
    var cities: [NSDictionary]?
    let count: String = "10"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(distance)
        
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        let apiKey = "dj0yJmk9a0t6UW5GYlZvMXFMJmQ9WVdrOWJrMTVlVmgxTlRBbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD01Mw--"
        let url = NSURL(string: "http://where.yahooapis.com/v1/place/2377942/siblings;count=\(count)?format=json&lang=en_US&appid=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            // modified info.plist to disable ATS for api link
                            print("response: \(responseDictionary)")
                            self.places = responseDictionary["places"] as? NSDictionary
                            self.cities = self.places!["place"] as? [NSDictionary]
                            self.citiesTableView.reloadData()
                    }
                }
        })
        task.resume()

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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let places = places{
            let intCount: Int =  places["count"] as! Int
            return intCount
        } else {
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        let city = cities![indexPath.row]
        let name = city["name"] as! String
        
        cell.titleLabel.text = name
        
        print("row \(indexPath.row)")
        return cell
        
    }


}
