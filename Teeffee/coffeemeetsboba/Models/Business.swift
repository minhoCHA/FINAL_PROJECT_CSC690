//
//  Business.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 3/24/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import UIKit
import CoreLocation

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImage: UIImage?
    let reviewCount: NSNumber?
    let url: URL?
    let price: String?
    let long: Double?
    let lat: Double?
    let phone: String?
    let redeemed: Bool?
    let coupon: String?
    let terms: String?
    let couponValue: String?
    
    init(dictionary: NSDictionary) {
        redeemed = false
        let phoneNum = dictionary["phone"] as? String
        if phoneNum != nil{
            phone = phoneNum
        } else{
            phone = "[ Check back later! ]"
        }
        
        
        let range = dictionary["price"] as? String
        if range != nil{
            price = range
        }else{
            price = "[ Check back later! ]"
        }
        
        let URLString = dictionary["url"] as? String
        if !URLString!.isEmpty {
            url = URL(string: URLString!)!
        } else {
            url = nil
        }
        
        name = dictionary["name"] as? String
        if name == "1951 Coffee Shop" {
            coupon = "UNLOCK SPECIAL OFFER!"
            terms = "Offer valid 5/9/2019 – 5/16/2019. Offer valid for one–time use. At 2410 Channing Way Berkeley, California 94704 location only. This offer cannot be combined with other offers, promotions or discounts, including stamps card."
            couponValue = "CONGRATS! YOU GOT: \n \n 10% OFF EVERYTHING!"
        }else if name == "Babette"{
            coupon = "UNLOCK SPECIAL OFFER!"
            terms = "Offer valid 5/9/2019 – 5/16/2019. At 2120 Oxford St Berkeley, CA 94720 location only. This offer cannot be combined with other offers, promotions or discounts."
            couponValue = "CONGRATS! YOU GOT: \n \n 10% OFF EVERYTHING!"
        } else {
            coupon = nil
            terms = nil
            couponValue = nil
        }
        
        let coordinates = dictionary["coordinates"] as? NSDictionary
        if coordinates != nil{
            long = coordinates!["longitude"] as? Double
            lat = coordinates!["latitude"] as? Double
        } else{
            long = nil
            lat = nil
        }
        
        
        let imageURLString = dictionary["image_url"] as? String
        if !imageURLString!.isEmpty {
                    imageURL = URL(string: imageURLString!)!
                } else {
            imageURL = URL(string: "https://s3-media1.fl.yelpcdn.com/assets/srv0/yelp_styleguide/4f30aa60678e/assets/img/default_avatars/business_large_square.png")
                }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["display_address"] as? NSArray
            if addressArray != nil {
                if addressArray!.count > 0 {
                    address = addressArray![0] as! String
                }
                if addressArray!.count > 1 {
                    address += ", " + (addressArray![1] as! String)
                }
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [NSDictionary]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category["title"] as! String
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let rating = dictionary["rating"] as? Double
        if rating != nil {
            switch rating {
            case 1:
                self.ratingImage = UIImage(named: "stars_1")
                break
            case 1.5:
                self.ratingImage = UIImage(named: "stars_1half")
                break
            case 2:
                self.ratingImage = UIImage(named: "stars_2")
                break
            case 2.5:
                self.ratingImage = UIImage(named: "stars_2half")
                break
            case 3:
                self.ratingImage = UIImage(named: "stars_3")
                break
            case 3.5:
                self.ratingImage = UIImage(named: "stars_3half")
                break
            case 4:
                self.ratingImage = UIImage(named: "stars_4")
                break
            case 4.5:
                self.ratingImage = UIImage(named: "stars_4half")
                break
            case 5:
                self.ratingImage = UIImage(named: "stars_5")
                break
            default:
                self.ratingImage = UIImage(named: "stars_0")
                break
            }
        } else {
            self.ratingImage = UIImage(named: "stars_0")
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            if (business.name != "Starbucks" && business.name != "7-Eleven" && business.name != "McDonald\'s" && !business.address!.contains("2495 Bancroft Way")) {
               businesses.append(business)
            }
        }
        return businesses
    }
    
    class func searchWithTerm2(term: String, lat:CLLocationDegrees, long:CLLocationDegrees, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term,lat: lat,long: long,completion: completion)
    }
    
    class func searchWithTerm(term: String, lat:CLLocationDegrees, long:CLLocationDegrees, sort: YelpSortMode?, categories: [String]?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, lat: lat,long: long,sort: sort, categories: categories, openNow: nil, completion: completion)
    }
}

