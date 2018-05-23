//
//  SoonViewModel.swift
//  liteKasta
//
//  Created by Bogachov on 17.05.2018.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit

extension ViewController {
    class SoonCampaigns: NSObject {
        let identifier: Int
        let firstTitle: String
        let secondTitle: String
        let thirdTitle: String
        let firstDesc: String
        let secondDesc: String
        let thirdDesc: String
        
        init(with aSoonCampaigns: [KastaAPI.Campaign]) {
            identifier = 0
            firstTitle = aSoonCampaigns[0].name
            secondTitle = aSoonCampaigns[1].name
            thirdTitle = aSoonCampaigns[2].name
            secondDesc = aSoonCampaigns[0].description
            firstDesc = aSoonCampaigns[1].description
            thirdDesc = aSoonCampaigns[2].description
            super.init()
        }
    }
}

extension ViewController.SoonCampaigns: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let o = object as? ViewController.SoonCampaigns else {
            return false
        }
        return firstTitle == o.firstTitle
            && secondTitle == o.secondTitle
            && thirdTitle == o.thirdTitle
            && firstDesc == o.firstDesc
            && secondDesc == o.secondDesc
            && thirdDesc == o.thirdDesc
    }
}

