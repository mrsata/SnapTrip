//
//  Business.swift
//  snaptrip
//
//  Created by LH on 2/26/16.
//  Copyright © 2016 mrsata. All rights reserved.

import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let rating: NSNumber?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        // imageURLString
        if let imageURLString = dictionary["image_url"] as? String {
            imageURL = NSURL(string: imageURLString)!
        } else {
            imageURL = nil
        }
        
        // location
        var address = ""
        if let location = dictionary["location"] as? NSDictionary {
            let addressArray = location["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        // categoriesArray
        if let categoriesArray = dictionary["categories"] as? [[String]] {
            var categoryNames = [String]()
            for category in categoriesArray {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        
        // distanceMeters
        if let distanceMeters = dictionary["distance"] as? NSNumber {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters.doubleValue)
        } else {
            distance = nil
        }
        
        // rating
        rating = dictionary["rating"] as? NSNumber
        
        // ratingImageURLString
        if let ratingImageURLString = dictionary["rating_img_url_large"] as? String {
            ratingImageURL = NSURL(string: ratingImageURLString)
        } else {
            ratingImageURL = nil
        }
        
        // reviewCount
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([Business]!, NSError!) -> Void) -> Void {
        YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    }
}
