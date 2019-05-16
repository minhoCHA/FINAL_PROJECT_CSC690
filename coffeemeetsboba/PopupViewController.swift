//
//  PopupViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 5/2/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import Foundation
import UIKit

class PopupViewController: UIViewController {
    
    var selectedBusiness : Business!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var coupon: UILabel!
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var topView: UIView!
    var isTea: Bool!
    @IBOutlet weak var terms: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
            self.cancelButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
        }else{
            self.cancelButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
        }
        //self.topView.layer.cornerRadius = min(self.topView.frame.size.width/2, self.topView.frame.size.height/2)
//        self.topView.layer.cornerRadius = topView.frame.size.height/2
//        self.topView.clipsToBounds = true
        
        self.topView.layer.cornerRadius = min(self.topView.frame.size.height, self.topView.frame.size.width) / 2.0
        self.topView.clipsToBounds = true
        
        
//        let width:CGFloat = UIScreen.main.bounds.width*0.0533
//        self.topView.frame = CGRect(0,0,width,width)
//        self.topView.layer.masksToBounds = true
//        self.topView.layer.cornerRadius = width/2
        
        //self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.height / 2
        self.cancelButton.clipsToBounds = true
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
    @IBAction func redeem(_ sender: Any) {
        //self.selectedBusiness.redeemed = true
        
    }
    
}
