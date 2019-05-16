//
//  restaurantDisplayViewController.swift
//  coffeemeetsboba
//
//  Created by Ganzolboo on 4/3/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import Foundation
import UIKit

class restaurantDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedBusiness: Business?
    var teaList: [Business]!
    var coffeeList: [Business]!
    var isTea: Bool!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var typeIcon: UIImageView!
    
    @IBOutlet weak var restaurantTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTea == true{
            return self.teaList.count
        }
        else{
            return self.coffeeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTea == true{
            if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell") as? restaurantTableViewCell{
                print("tea")
                cell.restaurantAddress.text = teaList[indexPath.row].address
                cell.numOfReview.text = (teaList[indexPath.row].reviewCount?.stringValue)! + " reviews"
                cell.restaurantImg.kf.setImage(with: teaList[indexPath.row].imageURL)
                cell.restaurantName.text = teaList[indexPath.row].name
                cell.restaurantName.font = UIFont(name:"Montserrat-Bold", size: 14.0)
                cell.restaurantDistance.text = teaList[indexPath.row].distance
                cell.ratingImg.image = teaList[indexPath.row].ratingImage
                return cell
            }
            return UITableViewCell()
        }
        else{
            if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell") as? restaurantTableViewCell{
                print("coffee")
                cell.restaurantAddress.text = coffeeList[indexPath.row].address
                cell.numOfReview.text = (coffeeList[indexPath.row].reviewCount?.stringValue)! + " reviews"
                cell.restaurantImg.kf.setImage(with: coffeeList[indexPath.row].imageURL)
                cell.restaurantName.text = coffeeList[indexPath.row].name
                cell.restaurantName.font = UIFont(name:"Montserrat-Bold", size: 14.0)
                cell.ratingImg.image = coffeeList[indexPath.row].ratingImage
                cell.restaurantDistance.text = coffeeList[indexPath.row].distance
                print(coffeeList[indexPath.row].distance)
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isTea == true{
            selectedBusiness = self.teaList[indexPath.row]
        }else{
            selectedBusiness = self.coffeeList[indexPath.row]
        }
        performSegue(withIdentifier: "goToMapView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? MapViewController{
                dest.isTea = self.isTea
                dest.selectedBusiness = self.selectedBusiness
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(tea)
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        // Do any additional setup after loading the view.
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
        }
    }
    
    
}

class  restaurantTableViewCell : UITableViewCell {
    
    @IBOutlet weak var numOfReview: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var ratingImg: UIImageView!
    @IBOutlet weak var restaurantDistance: UILabel!
    
}
