//
//  CampaignCell.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/3/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit

extension ViewController {
    class CampaignCell: UICollectionViewCell {
        // MARK: - improvement (removed title and desc, and used promotionView instead)
        let picture = UIImageView()
        let promotionView = PromotionView()
        // MARK: - improvement (removed image 'cornersOverlay', and used cornerRadius instead)
        private let cornerRadius: CGFloat = 5.0
        
        static let pictureAspect: CGFloat = 1.0 / 0.55
        static let captionBlockHeight: CGFloat = 76

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .campaignCellBackground
            isOpaque = true
            
            addSubview(picture)
            addSubview(promotionView)
            picture.layer.cornerRadius = cornerRadius
            picture.layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
            
        }
        
        func setup(with aCampaign: Campaign) {
            
            promotionView.titleLabel.text = aCampaign.title
            promotionView.descriptionLabel.text = aCampaign.desc
            if let url = URL(string: "https://modnakasta.ua/imgw/loc/0x0/\(aCampaign.bannerPath)") {
                picture.af_setImage(withURL: url)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func prepareForReuse() {
            picture.image = nil
            promotionView.titleLabel.text = nil
            promotionView.descriptionLabel.text = nil
            super.prepareForReuse()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            picture.frame   = CGRect(x: 0,
                                     y: 0,
                                     width: bounds.width,
                                     height: floor(bounds.width / CampaignCell.pictureAspect))
            promotionView.frame = CGRect(x: 0,
                                         y: picture.frame.maxY + 8,
                                         width: bounds.width,
                                         height: 40)
        }
        
        class func desiredHeightFor(columnWidth: CGFloat) -> CGFloat {
            return floor(columnWidth / pictureAspect) + captionBlockHeight;
        }
        
        class func listSingleSectionController() -> ListSingleSectionController {
            let controller = ListSingleSectionController(cellClass: CampaignCell.self, configureBlock: { (item, cell) in
                
                if let campaignCell = cell as? CampaignCell, let campaign = item as? Campaign {
                    campaignCell.setup(with: campaign)
                }
            }, sizeBlock: { (item, context) -> CGSize in
                
                let width = context!.insetContainerSize.width - 32 // 16pt inset on each side
                let height = CampaignCell.desiredHeightFor(columnWidth: width)
                
                return CGSize(width: width, height: height)
            })
            return controller
        }
    }
}
