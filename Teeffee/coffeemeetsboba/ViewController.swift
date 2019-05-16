//
//  ViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 3/21/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import Foundation
import UIKit
import TTFortuneWheel
import CDYelpFusionKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var isTea: Bool!
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!
    @IBOutlet weak var coffeeView: UIView!
    @IBOutlet weak var teaView: UIView!
    
    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let hover = CABasicAnimation(keyPath: "position")
        
        hover.isAdditive = true
        hover.fromValue = NSValue(cgPoint: CGPoint.zero)
        hover.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 15.0))
        hover.autoreverses = true
        hover.duration = 1
        hover.repeatCount = Float.infinity
        
        self.logo.layer.add(hover, forKey: "myHoverAnimation")
        
        //For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        let coffeeGesture = UITapGestureRecognizer(target: self, action:  #selector(self.pickCoffee(_:)))
        self.coffeeView.addGestureRecognizer(coffeeGesture)
        let teaGesture = UITapGestureRecognizer(target: self, action:  #selector(self.pickTea(_:)))
        self.teaView.addGestureRecognizer(teaGesture)
        
        self.coffeeView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 4, y: 4, blur: 20, spread: 0)
        self.teaView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 4, y: 4, blur: 20, spread: 0)

//        if(locationManager.location?.coordinate.latitude != nil){
//            Business.searchWithTerm(term: "tea", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!,sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
//                teaList = businesses
//                for business in teaList {
//                    print("TEA")
//                    print(business.name!)
//                    print(business.address!)
//                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
//                }
//            }
//
//            Business.searchWithTerm(term: "coffee", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
//                coffeeList = businesses
//                for business in coffeeList {
//                    print("COFFEE")
//                    print(business.name!)
//                    print(business.address!)
//                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
//                }
//            }
//        }

    }
    
    @objc func pickCoffee(_ sender: UITapGestureRecognizer) {
        isTea = false
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
    @objc func pickTea(_ sender: UITapGestureRecognizer) {
        isTea = true
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print("update")
        lat = locValue.latitude
        long = locValue.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? todaysPickViewController{
                dest.isTea = self.isTea
                dest.lat = self.lat
                dest.long = self.long
            }
        }
    }
    
}

//extension UIViewController{
//    @objc func swipeAction(swipe:UISwipeGestureRecognizer){
//        switch swipe.direction.rawValue {
//        case 1:
//            performSegue(withIdentifier: "swipeRight", sender: self)
//        case 2:
//           tea = false
//           performSegue(withIdentifier: "swipeRight", sender: self)
//        default:
//            break
//        }
//
//    }
//}
