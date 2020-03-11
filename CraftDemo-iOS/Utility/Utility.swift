//
//  Utility.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation
import UIKit

struct Preferences {
    
    struct Drawing {
        var center                  = CGPoint.zero
        var foregroundStrokeColor   = UIColor.red
        var trackStrokeColor        = UIColor.gray.withAlphaComponent(0.2)
        var lineWidth               = CGFloat(10)
        var lineCap                 = CAShapeLayerLineCap.round
        var clockwise               = true
        var showTrack               = true
    }
    
    struct Positioning {
        var arcPosition         = ArcPosition.bottom
        var fullCircleAngle     = 2 * CGFloat.pi
        
        func startAngle() -> CGFloat {
            switch arcPosition {
            case .bottom:
                break
            case .left:
                break
            case .top:
                break
            case .right:
                break
            }
            return .pi / 2
        }
        
        func endAngle(_ value: CGFloat) -> CGFloat {
            switch arcPosition {
            case .bottom:
                break
            case .left:
                break
            case .top:
                break
            case .right:
                break
            }
            /*
             percentage = (value - 300) / 600
             */
            let ratio = (value - 300) / 600
            return ratio * (3/2 * .pi) + (.pi / 2)
        }
    }
    
    struct Animating {
        
    }
    
    struct ViewData {
        var startText = ""
        var endText = ""
        var centerText = ""
        var score = 0.0
    }
    
    var drawing      = Drawing()
    var positioning  = Positioning()
    var animating    = Animating()
    var data = ViewData()
}
