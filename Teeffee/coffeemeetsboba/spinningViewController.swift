////
////  spinningViewController.swift
////  coffeemeetsboba
////
////  Created by aliceyang on 3/24/19.
////  Copyright © 2019 aliceyang. All rights reserved.
////
//
//import Foundation
//import UIKit
//import TTFortuneWheel
//import CDYelpFusionKit
//
//
//class spinningViewController: UIViewController {
//
//    @IBOutlet weak var spinningWheel: TTFortuneWheel!
//    //var businesses: [Business]!
//    var slices = [CarnivalWheelSlice]()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if tea == true{
//            self.slices = [CarnivalWheelSlice.init(title: teaList[0].name!),
//                           CarnivalWheelSlice.init(title: teaList[1].name!),
//                           CarnivalWheelSlice.init(title: teaList[2].name!),
//                           CarnivalWheelSlice.init(title: teaList[3].name!),
//                           CarnivalWheelSlice.init(title: teaList[4].name!),
//                           CarnivalWheelSlice.init(title: teaList[5].name!),
//                           CarnivalWheelSlice.init(title: teaList[6].name!),
//                           CarnivalWheelSlice.init(title: teaList[7].name!)
//            ]
//        } else{
//            self.slices = [CarnivalWheelSlice.init(title: coffeeList[0].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[1].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[2].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[3].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[4].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[5].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[6].name!),
//                           CarnivalWheelSlice.init(title: coffeeList[7].name!)]
//
//        }
//
//
//
////        let slices = [ CarnivalWheelSlice.init(title: "test"),
////                       CarnivalWheelSlice.init(title: "Try again"),
////                       CarnivalWheelSlice.init(title: "Free\nticket"),
////                       CarnivalWheelSlice.init(title: "Teddy\nbear"),
////                       CarnivalWheelSlice.init(title: "Large popcorn"),
////                       CarnivalWheelSlice.init(title: "Balloon figures"),
////                       CarnivalWheelSlice.init(title: "Ferris Wheel"),
////                       CarnivalWheelSlice.init(title: "Pony\nRide")]
//        spinningWheel.slices = self.slices
//        spinningWheel.equalSlices = true
//        spinningWheel.frameStroke.width = 0
//        spinningWheel.slices.enumerated().forEach { (pair) in
//            let slice = pair.element as! CarnivalWheelSlice
//            let offset = pair.offset
//            switch offset % 4 {
//            case 0: slice.style = .brickRed
//            case 1: slice.style = .sandYellow
//            case 2: slice.style = .babyBlue
//            case 3: slice.style = .deepBlue
//            default: slice.style = .brickRed
//            }
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func rotateButton(_ sender: Any) {
//
//        spinningWheel.startAnimating()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//            self.spinningWheel.startAnimating(fininshIndex: 5) { (finished) in
//                print(finished)
//            }
//        }
//    }
//
//
//
//
//
//
//}
