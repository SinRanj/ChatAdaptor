//
//  Configurations.swift
//  ChatAdaptor
//
//  Created by Sina on 12/13/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

struct ChatConfigurations {
    
    struct Colors {
        static let sharedInstance = Colors()
        var chatViewHolderBackGroundColor:UIColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        private var colors:[UIColor] =
            [UIColor(red: 164/255, green: 184/255, blue: 196/255, alpha: 1),
             UIColor(red: 185/255, green: 216/255, blue: 194/255, alpha: 1),
             UIColor(red: 37/255, green: 78/255, blue: 112/255, alpha: 1),
             UIColor(red: 58/255, green: 67/255, blue: 94/255, alpha: 1),
             UIColor(red: 227/255, green: 101/255, blue: 91/255, alpha: 1),
             UIColor(red: 219/255, green: 84/255, blue: 97/255, alpha: 1),
             UIColor(red: 46/255, green: 94/255, blue: 170/255, alpha: 1),
             UIColor(red: 92/255, green: 71/255, blue: 66/255, alpha: 1)
            ]
        
        /// Return a color randomly from array of colors.
        func randomizeColor()->UIColor{
            let random = Int.random(in: 0..<colors.count)
            return colors[random]
        }
    }
    struct MessageConfigurations {
        static var sharedInstance = MessageConfigurations()
        var shouldFlip = true
    }
    
}
