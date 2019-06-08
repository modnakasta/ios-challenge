//
//  CampaignViewModel.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/3/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit

extension ViewController {
    class Campaign: NSObject {
        let identifier: Int
        let title: String
        let desc: String
        let countdownToDate: Date
        let bannerPath: String
        let codename: String
        
        init(with aCampaign: KastaAPI.Campaign) {
            identifier = aCampaign.id
            title = aCampaign.name
            desc = aCampaign.description
            countdownToDate = aCampaign.finishesAt
            bannerPath = aCampaign.nowImage
            codename = aCampaign.codename
            super.init()
        }
    }
    
    class SoonCampaign: NSObject {
        let campaigns: [Campaign]
        
        init(with aCampaigns: [KastaAPI.Campaign]) {
            campaigns = aCampaigns.map() { Campaign(with: $0) }
        }
    }
}

extension ViewController.Campaign: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let o = object as? ViewController.Campaign else {
            return false
        }
        return title == o.title && desc == o.desc && countdownToDate == o.countdownToDate && bannerPath == o.bannerPath
    }
}

extension ViewController.SoonCampaign: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return hashValue as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let o = object as? ViewController.SoonCampaign else {
            return false
        }
        return campaigns == o.campaigns
    }
}

