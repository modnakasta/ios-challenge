//
//  NetworkManager.swift
//  liteKasta
//
//  Created by Zinkov Artem on 6/8/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Moya

class NetworkManager: NSObject {
    let provider: MoyaProvider<KastaAPI>

    init(provider: MoyaProvider<KastaAPI>) {
        self.provider = provider
    }
    
    func fetch(_ completion: @escaping ((activeAndSoonCampaigns?, Error?)->())) {
        provider.request(.campaigns) { result in
            do {
                switch result {
                    
                case .success(let response):
                    let response = try response.filterSuccessfulStatusAndRedirectCodes()
                    let campaigns = try response.map([KastaAPI.Campaign].self, atKeyPath: "items", using: KastaAPI.Campaign.decoder)
                    
                    let (activeCampaignsModel, soonCampaignsModel, _) = campaigns.filterActive(for: Date())
                    
                    let notVirtualActiveCampaigns = activeCampaignsModel.filter { !$0.isVirtual }
                    let notVirtualSoonCampaigns = soonCampaignsModel.filter { !$0.isVirtual }
                    
                    completion((notVirtualActiveCampaigns, notVirtualSoonCampaigns), nil)                    
                case .failure(let error):
                    completion(nil, error)
                    throw error
                }
            }
                
            catch let error {
                completion(nil, error)
            }
        }
    }
}
