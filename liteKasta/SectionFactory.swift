//
//  SectionFabric.swift
//  liteKasta
//
//  Created by Bogachov on 17.05.2018.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit
import IGListKit
struct SectionFactory {
    static func createSoonSectionController(viewController: ViewController, object: Any) -> ListSingleSectionController {
        let controller = ListSingleSectionController(cellClass: ViewController.SoonCell.self, configureBlock: { (item, cell) in
            let soonCell = cell as! ViewController.SoonCell
            let soonCampaigns = item as! ViewController.SoonCampaigns
            
            soonCell.firstTitle.text = soonCampaigns.firstTitle
            soonCell.firstDesc.text = soonCampaigns.firstDesc
            soonCell.secondTitle.text = soonCampaigns.secondTitle
            soonCell.secondDesc.text = soonCampaigns.secondDesc
            soonCell.thirdTitle.text = soonCampaigns.thirdTitle
            soonCell.thirdDesc.text = soonCampaigns.thirdDesc
            
        }, sizeBlock: { (item, context) -> CGSize in
            
            let width = context!.insetContainerSize.width - 32 // 16pt inset on each side
            let height = ViewController.CampaignCell.desiredHeightFor(columnWidth: width)
            
            return CGSize(width: width, height: height)
            
        })
        
        guard case .success(let items) = viewController.state else {
            fatalError("Fetch state != .success, the collection should have no sections, yet the adapter requests one, wtf?")
        }
        
        controller.selectionDelegate = viewController
        
        let currentItem = object as! ListDiffable
        let isFirstItem = currentItem.isEqual(toDiffableObject: items.first)
        
        controller.inset = UIEdgeInsets(top: isFirstItem ? 32 : 0, left: 16, bottom: 16, right: 16)
        
        return controller
    }
    
    static func createCampaignSectionController(viewController: ViewController, object: Any) -> ListSingleSectionController {
        let controller = ListSingleSectionController(cellClass: ViewController.CampaignCell.self, configureBlock: { (item, cell) in
            let campaignCell = cell as! ViewController.CampaignCell
            let campaign = item as! ViewController.Campaign

            campaignCell.title.text = campaign.title
            campaignCell.desc.text = campaign.desc
            if let url = URL(string: "https://modnakasta.ua/imgw/loc/0x0/\(campaign.bannerPath)") {
                campaignCell.picture.af_setImage(withURL: url,placeholderImage: UIImage(named: "brokenImage"))
            }
            
        }, sizeBlock: { (item, context) -> CGSize in
            
            let width = context!.insetContainerSize.width - 32 // 16pt inset on each side
            let height = ViewController.CampaignCell.desiredHeightFor(columnWidth: width)
            
            return CGSize(width: width, height: height)
            
        })
        
        guard case .success(let items) = viewController.state else {
            fatalError("Fetch state != .success, the collection should have no sections, yet the adapter requests one, wtf?")
        }
        
        controller.selectionDelegate = viewController
        
        let currentItem = object as! ListDiffable
        let isFirstItem = currentItem.isEqual(toDiffableObject: items.first)
        
        controller.inset = UIEdgeInsets(top: isFirstItem ? 32 : 0, left: 16, bottom: 16, right: 16)
        
        return controller
    }
}
