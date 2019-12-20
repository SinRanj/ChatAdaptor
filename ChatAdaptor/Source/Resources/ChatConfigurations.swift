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
        static var colors = Colors()
        
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
        
        /// Color for chat's background
        var chatBackgroundColor:UIColor! = UIColor.white
        
        var textColor:UIColor! = UIColor.black
        
        var sendBubleViewBackGroundColor:UIColor! = UIColor(red: 88/255, green: 136/255, blue: 140/255, alpha: 1)
        
        var bubleTextColor:UIColor! = UIColor.white
        
        
        var receiveBubleViewBackGroundColor:UIColor! = UIColor(red: 137/255, green: 144/255, blue: 159/255, alpha: 1)
        
    }
    struct MessageConfigurations {
        static var messageConfigurations = MessageConfigurations()
        var shouldFlip = true
    }
    
    struct Icons {
        static var icons = Icons()
        
        var sendButtonIcon:UIImage? = nil
        
        var attachmentIcon:UIImage! = UIImage(named: "attachment")
        
        var downIcon:UIImage! = UIImage(named: "down")
    }
    
    struct Fonts {
        static var fonts = Fonts()
        var messageFont:UIFont = UIFont.systemFont(ofSize: 12)
    }
}
