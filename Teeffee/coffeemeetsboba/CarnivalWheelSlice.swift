//
//  CarnivalWheelSlice.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 3/24/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import TTFortuneWheel

public class CarnivalWheelSlice: FortuneWheelSliceProtocol {
    
    public enum Style {
        case brickRed
        case sandYellow
        case babyBlue
        case deepBlue
    }
    
    public var title: String
    public var degree: CGFloat = 0.0
    
    public var backgroundColor: UIColor? {
        switch style {
        case .brickRed: return TTUtils.uiColor(from:0xE27230)
        case .sandYellow: return TTUtils.uiColor(from:0xF7D565)
        case .babyBlue: return TTUtils.uiColor(from:0x93D0C4)
        case .deepBlue: return TTUtils.uiColor(from:0x2A7F7F)
        }
    }
    
    public var fontColor: UIColor {
        return UIColor.white
    }
    
    public var offsetFromExterior:CGFloat {
        return 10.0
    }
    
    public var font: UIFont {
        switch style {
        case .brickRed: return UIFont(name: "Kefa", size: 22.0)!
        case .sandYellow: return UIFont(name: "Kefa", size: 22.0)!
        case .babyBlue: return UIFont(name: "Kefa", size: 22.0)!
        case .deepBlue: return UIFont(name: "Kefa", size: 22.0)!
        }
    }
    
    public var stroke: StrokeInfo? {
        return StrokeInfo(color: UIColor.white, width: 1.0)
    }
    
    public var style:Style = .brickRed
    
    public init(title:String) {
        self.title = title
    }
    
    public convenience init(title:String, degree:CGFloat) {
        self.init(title:title)
        self.degree = degree
    }
    
}

