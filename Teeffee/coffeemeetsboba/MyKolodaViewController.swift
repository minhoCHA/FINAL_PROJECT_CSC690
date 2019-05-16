////
////  MyKolodaViewController.swift
////  coffeemeetsboba
////
////  Created by aliceyang on 4/10/19.
////  Copyright © 2019 aliceyang. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Koloda
//
//class MyKolodaViewController: UIViewController {
//    //@IBOutlet weak var kolodaView: KolodaView!
//    
//    @IBOutlet weak var kolodaView: KolodaView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        kolodaView.dataSource = self
//        kolodaView.delegate = self
//    }
//}
//
//extension MyKolodaViewController: KolodaViewDelegate {
//    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        koloda.reloadData()
//    }
//    
//    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
//    }
//}
//
//extension MyKolodaViewController: KolodaViewDataSource {
//    
//    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
//        return teaList.count
//    }
//    
//    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
//        return .fast
//    }
//    
//    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
//        //return UIImageView(image: images[index])
//    
//        let url = teaList[index].imageURL
//        if let data = try? Data(contentsOf: url!)
//        {
//            let image: UIImage = UIImage(data: data)!
//            return UIImageView(image: image)
//        }
//        return UIImageView()
//    }
//    
////    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
////        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
////    }
//}
//
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//
