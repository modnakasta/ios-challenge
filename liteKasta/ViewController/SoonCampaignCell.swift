//
//  SoonCampaignCell.swift
//  liteKasta
//
//  Created by Zinkov Artem on 6/8/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import IGListKit

extension ViewController {
    class SoonCampaignCell: UICollectionViewCell {
        
        let titleLabel = UILabel()
        let promotionViews = UIStackView()
        let allPromotionsButton = UIButton()
        var countOfCampaigns: Int!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .campaignCellBackground
            
            promotionViews.axis = .vertical
            promotionViews.alignment = .fill
            promotionViews.spacing = 0.0
            addSubview(promotionViews)
            layer.cornerRadius = 5.0
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setup(with soonCampaign: ViewController.SoonCampaign) {
            setupLabel()
            setupPromotionViews(with: soonCampaign)
            setupButton()
        }
        
        private func setupLabel() {
            
            addSubview(titleLabel)
            titleLabel.text = "Скоро в продаже"
            titleLabel.textColor = UIColor(rgb: 0xD2D2D4)
            titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            titleLabel.frame = CGRect(x: 16, y: 8, width: bounds.width, height: 18)
        }
        
        private func setupPromotionViews(with soonCampaign: ViewController.SoonCampaign) {
            
            countOfCampaigns = min(soonCampaign.campaigns.count, 3)
            var i = 0
            while i < countOfCampaigns {
                
                let promotionView = PromotionView()
                promotionViews.addSubview(promotionView)
                promotionView.titleLabel.text = soonCampaign.campaigns[i].title
                promotionView.descriptionLabel.text = soonCampaign.campaigns[i].desc
                
                let height: CGFloat = 64
                promotionView.frame = CGRect(x: 0,
                                             y: CGFloat(i) * height + 8,
                                             width: bounds.width,
                                             height: height)
                
                i += 1
            }
            promotionViews.frame = CGRect(x: 0,
                                          y: titleLabel.frame.maxY,
                                          width: frame.width,
                                          height: (frame.height - titleLabel.frame.height) / 4.5 * CGFloat(countOfCampaigns))
        }
        
        private func setupButton() {
            
            addSubview(allPromotionsButton)
            allPromotionsButton.setTitle("Все предстоящие акции", for: .normal)
            allPromotionsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            allPromotionsButton.setTitleColor(UIColor(rgb: 0x4FB748), for: .normal)
            allPromotionsButton.contentHorizontalAlignment = .left
            allPromotionsButton.addTarget(self, action: #selector(allPromotionsButtonTapped), for: .touchUpInside)
            allPromotionsButton.frame = CGRect(x: 16,
                                               y: promotionViews.frame.maxY + titleLabel.frame.maxY,
                                               width: bounds.width,
                                               height: 18)
        }
        
        @objc func allPromotionsButtonTapped(_ sender: UIButton) {
            UIApplication.shared.openURL(KastaAPI.soonURL)
        }
        
        class func listSingleSectionController() -> ListSingleSectionController {
            let controller = ListSingleSectionController(cellClass: SoonCampaignCell.self, configureBlock: { (item, cell) in
                
                if let campaignCell = cell as? SoonCampaignCell, let campaign = item as? ViewController.SoonCampaign {
                    campaignCell.setup(with: campaign)
                }
            }, sizeBlock: { (item, context) -> CGSize in
                
                guard let soonCampaign = item as? SoonCampaign else { return .zero }
                let countOfCampaigns = min(soonCampaign.campaigns.count, 3)

                let width = context!.insetContainerSize.width - 32 // 16pt inset on each side
                let height = 64 * CGFloat(countOfCampaigns) + 90
                
                return CGSize(width: width, height: height)
            })
            return controller
        }
    }
}


class PromotionView: UIView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .campaignCellBackground
        isOpaque = true
        backgroundColor = .clear
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        addSubview(titleLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = UIColor(rgb: 0x8E8E93)
        addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame        = CGRect(x: 16, y: 8, width: bounds.width - 32, height: 22)
        descriptionLabel.frame  = CGRect(x: 16, y: 32, width: bounds.width - 32, height: 18)
    }
}
