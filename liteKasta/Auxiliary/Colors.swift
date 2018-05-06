//
//  Colors.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/2/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: 1.0
        )
    }
    
    
    static let appBackground = UIColor(rgb: 0x20202A)
    static let campaignCellBackground = UIColor.white
    static let normalText = UIColor.black
    static let subtitledText = UIColor(rgb: 0xD2D2D4)
    
    static let saleTitleText = UIColor(rgb: 0x181818)
    static let saleDescriptionText = UIColor(rgb: 0x8E8E93)
    static let saleButtonText = UIColor(rgb: 0x4FB748)
}

