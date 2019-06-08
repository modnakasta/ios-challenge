//
//  API.Campaign.swift
//  ikasta
//
//  Created by Zoreslav Khimich on 1/12/18.
//  Copyright © 2018 modnakasta. All rights reserved.
//

import Foundation

extension KastaAPI {
    struct Campaign: Codable, TimeFramed, Tagged {
        let id: Int
        let name: String
        let description: String
        let startsAt: Date
        let finishesAt: Date
        let mods: [Mod]
        let nowImage: String
        let tags: String
        let codename: String
        // MARK: Aditional - for hiding virtual promotions
        var isVirtual: Bool { return mods.contains(where: { $0.name == "virtual" }) }
        
        static let decoder = KastaAPI.standardDecoder
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case description = "description"
            case startsAt = "starts_at"
            case finishesAt = "finishes_at"
            case mods = "mods"
            case nowImage = "now_image"
            case tags = "tags"
            case codename = "code_name"
        }
    }
    
    struct Mod: Codable {
        let name: String
    }
}
