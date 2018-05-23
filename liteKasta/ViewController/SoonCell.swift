//
//  SoonCell.swift
//  liteKasta
//
//  Created by Bogachov on 17.05.2018.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import Foundation
import UIKit
extension ViewController {
    class SoonCell: UICollectionViewCell {
        let title = UILabel()
        let firstTitle = UILabel()
        let firstDesc = UILabel()
        let secondTitle = UILabel()
        let secondDesc = UILabel()
        let thirdTitle = UILabel()
        let thirdDesc = UILabel()
        let allSoonLink = UIButton()
        let cornersOverlay = UIImageView(image: UIImage(named: "CampaignCell/4ptClipCorners"))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .campaignCellBackground
            isOpaque = true
            
            title.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
            title.textColor = .greyText
            title.text = NSLocalizedString("soon.campaing.title", comment: "Soon campaning title").uppercased()
            addSubview(title)
            
            firstTitle.font =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
            firstTitle.textColor = .normalText
            addSubview(firstTitle)
            
            firstDesc.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            firstDesc.textColor = .descriptionGreyText
            addSubview(firstDesc)
            
            secondTitle.font =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
            secondTitle.textColor = .normalText
            addSubview(secondTitle)
            
            secondDesc.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            secondDesc.textColor = .descriptionGreyText
            addSubview(secondDesc)
            
            thirdTitle.font =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
            thirdTitle.textColor = .normalText
            addSubview(thirdTitle)
            
            thirdDesc.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            thirdDesc.textColor = .descriptionGreyText
            addSubview(thirdDesc)
            
            allSoonLink.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
            allSoonLink.setTitleColor(.greenText, for: .normal)
            allSoonLink.setTitle(NSLocalizedString("all.soon.camping.button", comment: "Title of green button"), for: .normal)
            allSoonLink.contentHorizontalAlignment = .left
            allSoonLink.addTarget(self, action: #selector(allSoonDidTap), for: .touchUpInside)
            
            //allSoonLink.
            addSubview(allSoonLink)
            
            addSubview(cornersOverlay)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("Not supported")
        }
        
        override func prepareForReuse() {
            firstTitle.text = nil
            firstDesc.text = nil
            secondTitle.text = nil
            secondDesc.text = nil
            thirdTitle.text = nil
            thirdDesc.text = nil
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            let soonLabelTopMargin = frame.height * 0.05673
            let soonLabelHeight = frame.height * 0.05673
            let titleTopMargin = frame.height * 0.078
            let titleHeight = frame.height * 0.078
            let descTopMargin = frame.height * 0.00709
            let descHeight = frame.height * 0.06382
            let allSoonLinkBottomMargin = frame.height * 0.12056
            
            title.frame = CGRect(x: 16, y: soonLabelTopMargin, width: bounds.width - 12, height: soonLabelHeight)
            firstTitle.frame = CGRect(x: 17, y: title.frame.maxY + titleTopMargin, width: bounds.width - 32, height: titleHeight)
            firstDesc.frame = CGRect(x: 17, y: firstTitle.frame.maxY + descTopMargin, width: firstTitle.frame.width, height: descHeight)
            secondTitle.frame = CGRect(x: 17, y: firstDesc.frame.maxY + titleTopMargin, width: firstTitle.frame.width, height: titleHeight)
            secondDesc.frame = CGRect(x: 17, y: secondTitle.frame.maxY + descTopMargin, width: firstTitle.frame.width, height: descHeight)
            thirdTitle.frame = CGRect(x: 17, y: secondDesc.frame.maxY + titleTopMargin, width: firstTitle.frame.width, height: titleHeight)
            thirdDesc.frame = CGRect(x: 17, y: thirdTitle.frame.maxY + descTopMargin, width: firstTitle.frame.width, height: descHeight)
            allSoonLink.frame = CGRect(x: 16, y: bounds.maxY - allSoonLinkBottomMargin, width: firstTitle.frame.width, height: descHeight)
            cornersOverlay.frame = bounds
        }
        
        @objc func allSoonDidTap() {
            if let webURL = URL(string: "https://modnakasta.ua/#soon") {
                UIApplication.shared.openURL(webURL)
            }
        }
    }
}
