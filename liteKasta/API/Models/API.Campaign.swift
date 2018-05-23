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
        let nowImage: String
        let tags: String
        let codename: String
        let mods: [[String:String]]?
        
        static let decoder = KastaAPI.standardDecoder
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self,forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            description = try container.decode(String.self, forKey: .description)
            startsAt = try container.decode(Date.self, forKey: .startsAt)
            finishesAt = try container.decode(Date.self, forKey: .finishesAt)
            nowImage = try container.decode(String.self, forKey: .nowImage)
            tags = try container.decode(String.self, forKey: .tags)
            codename = try container.decode(String.self, forKey: .codename)
            mods = try container.decode(Array<[String:String]>.self, forKey: .mods)
        }
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case description = "description"
            case startsAt = "starts_at"
            case finishesAt = "finishes_at"
            case nowImage = "now_image"
            case tags = "tags"
            case codename = "code_name"
            case mods = "mods"
        }
    }
}
