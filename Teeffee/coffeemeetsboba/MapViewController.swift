//
//  MapViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 2019/4/4.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: "restaurantInfoViewCell") as? restaurantInfoViewCell{
            switch indexPath.row {
            case 0:
                cell.restaurantInfo.text = ""
                cell.restaurantInfo.isHidden = true
                cell.infoIcon.image = UIImage(named: "url-icon")
                cell.infoText.isEditable = false
                cell.infoText.dataDetectorTypes = UIDataDetectorTypes.link
                cell.infoText.text = self.selectedBusiness.url?.absoluteString
                cell.infoText.textContainer.maximumNumberOfLines = 2
                cell.infoText.textContainer.lineBreakMode = .byClipping
                cell.infoText.centerVertically()
                
            case 1:
//                cell.restaurantInfo.text = ""
//                cell.restaurantInfo.isHidden = true
                cell.infoIcon.image = UIImage(named: "phone-icon")
                if self.selectedBusiness.phone != "" {
                    cell.infoText.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
                    cell.infoText.text = self.selectedBusiness.phone
                    cell.infoText.alignTextVerticallyInContainer()
                    cell.infoText.isEditable = false
                } else{
                    cell.restaurantInfo.text = "[ Check back later! ]"
                    cell.infoText.isEditable = false
                    cell.infoText.isHidden = true
                }
                
            case 2:
                cell.restaurantInfo.text = self.selectedBusiness.price
                cell.infoIcon.image = UIImage(named: "price-icon")
                cell.infoText.isEditable = false
                cell.infoText.isHidden = true
            default:
                cell.restaurantInfo.text = ""
            }
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
    
    @IBOutlet weak var restaurantInfoTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var meetFriendsButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var isTea : Bool!
    var selectedBusiness : Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        restaurantInfoTableView.delegate = self
        restaurantInfoTableView.dataSource = self
        restaurantInfoTableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    func initView(){
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
            meetFriendsButton.backgroundColor = topView.backgroundColor
        }
        getDirectionButton.layer.borderColor = topView.backgroundColor?.cgColor
        
        // populate yelp data to view
        self.businessNameLabel.text = selectedBusiness.name
        self.addressLabel.text = selectedBusiness.address
        self.distanceLabel.text = selectedBusiness.distance
        
        // init map view
        let store = MKPointAnnotation()
        store.title = selectedBusiness.name
        let coordinate = CLLocationCoordinate2D(latitude: selectedBusiness.lat!, longitude: selectedBusiness.long! )
//        let coordinate = CLLocationCoordinate2D(latitude: 37.872574, longitude: -122.260748) Double(selectedBusiness!.long as NSNumber)
        
        store.coordinate = coordinate
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500), animated: true)
        mapView.addAnnotation(store)
    }
    
    @IBAction func getDirectionButtonClicked(_ sender: Any) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?saddr=&daddr=\(String(describing: selectedBusiness.lat!)),\(String(describing: selectedBusiness.long!))&directionsmode=walking")! as URL)
            
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
}

class  restaurantInfoViewCell : UITableViewCell {
    @IBOutlet weak var restaurantInfo: UILabel!
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoText: UITextView!
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2.0
        //var topCorrect = (self.bounds.size.height - self.contentSize.height) / 2.0
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
