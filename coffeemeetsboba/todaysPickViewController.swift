//
//  todaysPickViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 4/3/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import CoreLocation


class todaysPickViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var numOfPickLeft: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantInfoLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var pickView: UIView!
    
    var selectedBusiness: Business?
    var numOfPick = 1
    
    var teaList: [Business]!
    var coffeeList: [Business]!
    var isTea: Bool!
    
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!
    var promotionList = ["OUR FAVORITE!", "TOP PICK!", "NOW OPEN!", "ENJOY A DRINK!","TAKE A BREAK!"]
    var found1951 = false
    var foundBabette = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
        }
        self.pickView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 4, y: 4, blur: 20, spread: 0)
        self.restaurantImg.layer.cornerRadius = 25
        self.restaurantImg.clipsToBounds = true
        self.promotionButton.layer.cornerRadius = self.promotionButton.bounds.size.height / 2
        self.promotionButton.clipsToBounds = true
        
        // Create the Activity Indicator
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        
        // Start the loading animation
        activityIndicator.startAnimating()
        
        // To remove it, just call removeFromSuperview()
        //activityIndicator.removeFromSuperview()
        
        
        
        if isTea{
            Business.searchWithTerm(term: "", lat: lat, long: long,sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
                self.teaList = businesses
                //activityIndicator.removeFromSuperview()
//                if let randomElement = self.teaList.randomElement() {
//                    self.restaurantInfoLabel.text = randomElement.name
//                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
//                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
//                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
//                    self.promotionButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
//                    self.selectedBusiness = randomElement
                }
            Business.searchWithTerm(term: "", lat: lat, long: long, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops","cafes"]) { (businesses, error) in
                self.coffeeList = businesses
                activityIndicator.removeFromSuperview()
                for business in self.coffeeList {
                    if business.name == "1951 Coffee Shop"{
                        self.restaurantInfoLabel.text = business.name
                        self.restaurantImg.kf.setImage(with: business.imageURL)
                        self.restaurantDistanceLabel.text = business.distance! + " away"
                        //           self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                        self.promotionButton.setTitle(business.coupon, for: .normal)
//                        self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
                        self.promotionButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
                        self.selectedBusiness = business
                        self.found1951 = true
                    }
                }
                if !self.found1951 {
                                    if let randomElement = self.teaList.randomElement() {
                                        self.restaurantInfoLabel.text = randomElement.name
                                        self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                                        self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                                        self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                                        self.promotionButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
                                        self.selectedBusiness = randomElement
                                    }
                }
                
            }
        }else{
            Business.searchWithTerm(term: "", lat: lat, long: long, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops","cafes"]) { (businesses, error) in
                self.coffeeList = businesses
                activityIndicator.removeFromSuperview()
                for business in self.coffeeList {
                    if business.name == "1951 Coffee Shop"{
                        self.restaurantInfoLabel.text = business.name
                        self.restaurantImg.kf.setImage(with: business.imageURL)
                        self.restaurantDistanceLabel.text = business.distance! + " away"
//           self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                        self.promotionButton.setTitle(business.coupon, for: .normal)
                        self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
                        self.selectedBusiness = business
                        self.found1951 = true
                    }
                }
                if !self.found1951 {
                    if let randomElement = self.coffeeList.randomElement() {
                        self.restaurantInfoLabel.text = randomElement.name
                        self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                        self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                        self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                        self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
                        self.selectedBusiness = randomElement
                    }
                }
                
                
//                if let randomElement = self.coffeeList.randomElement() {
//                    self.restaurantInfoLabel.text = randomElement.name
//                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
//                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
//                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
//                    self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
//                    self.selectedBusiness = randomElement
//                }
            }
        }

        
//        if isTea == true{
//            if let randomElement = self.teaList.randomElement() {
//                //print(randomElement.address)
//                restaurantInfoLabel.text = randomElement.name
//                restaurantImg.kf.setImage(with: randomElement.imageURL)
//                restaurantDistanceLabel.text = randomElement.distance! + " away"
//                selectedBusiness = randomElement
//            }
//
//        } else{
//            colorCard.image = UIImage(named:"yellowcard")
//            displayIcon.image = UIImage(named:"tea")
//            if let randomElement = self.coffeeList.randomElement() {
//                restaurantInfoLabel.text = randomElement.name
//                restaurantImg.kf.setImage(with: randomElement.imageURL)
//                restaurantDistanceLabel.text = randomElement.distance! + " away"
//                selectedBusiness = randomElement
//            }
//
//        }
        
    }
    
    
    @IBAction func skip(_ sender: Any) {
        if numOfPick == 1{
            for business in self.coffeeList {
                if business.name == "Babette"{
                    self.restaurantInfoLabel.text = business.name
                    self.restaurantImg.kf.setImage(with: business.imageURL)
                    self.restaurantDistanceLabel.text = business.distance! + " away"
                    //           self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    self.promotionButton.setTitle(business.coupon, for: .normal)
                    if isTea{
                        self.promotionButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
                    }else{
                        self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
                    }
                    self.selectedBusiness = business
                    self.foundBabette = true
                }
            }
            if !self.foundBabette{
                if isTea == true{
                    if let randomElement = self.teaList.randomElement() {
                        restaurantInfoLabel.text = randomElement.name
                        restaurantImg.kf.setImage(with: randomElement.imageURL)
                        restaurantDistanceLabel.text = randomElement.distance! + " away"
                        self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                        selectedBusiness = randomElement
                    }
                } else{
                    if let randomElement = self.coffeeList.randomElement() {
                        restaurantInfoLabel.text = randomElement.name
                        restaurantImg.kf.setImage(with: randomElement.imageURL)
                        restaurantDistanceLabel.text = randomElement.distance! + " away"
                        self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                        selectedBusiness = randomElement
                    }
                }
            }
            let numOfPickLeftLabel = "You have " + String(numOfPick) + " pick(s) left!"
            numOfPickLeft.text = numOfPickLeftLabel
            numOfPick-=1
        }
        else if numOfPick == 0{
            if isTea == true{
                if let randomElement = self.teaList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                    restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    selectedBusiness = randomElement
                }
            } else{
                if let randomElement = self.coffeeList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                    restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    selectedBusiness = randomElement
                }
                
            }
            let numOfPickLeftLabel = "You have " + String(numOfPick) + " pick(s) left!"
            numOfPickLeft.text = numOfPickLeftLabel
            numOfPick-=1
        }else{
            performSegue(withIdentifier: "browseMore", sender: sender)
        }
        
    }
    
    
    @IBAction func goToPick(_ sender: Any) {
        performSegue(withIdentifier: "goToPick", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? MapViewController{
                dest.isTea = self.isTea
                dest.selectedBusiness = self.selectedBusiness
            }
            
            if let dest2 = segue.destination as? restaurantDisplayViewController{
                dest2.isTea = self.isTea
                dest2.coffeeList = self.coffeeList
                dest2.teaList = self.teaList
            }
        }
    }
    
    
    @IBAction func showPopup(_ sender: Any) {
        if self.selectedBusiness?.name == "1951 Coffee Shop" ||  self.selectedBusiness?.name == "Babette" {
            let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopupID") as! PopupViewController
            self.addChild(popOverVc)
            popOverVc.isTea = self.isTea
            popOverVc.view.frame = self.view.frame
            popOverVc.coupon.text = self.selectedBusiness?.couponValue
            popOverVc.selectedBusiness = self.selectedBusiness
            popOverVc.businessName.text = self.selectedBusiness?.name
            popOverVc.terms.text = self.selectedBusiness?.terms
            //popOverVc.isTea = self.isTea
            self.view.addSubview(popOverVc.view)
            popOverVc.didMove(toParent: self)
        }
    }
    

    
    
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
