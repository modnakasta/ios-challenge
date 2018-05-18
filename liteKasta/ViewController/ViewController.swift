//
//  ViewController.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/2/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit
import Moya
import AlamofireImage

class ViewController: UIViewController {
    
    let provider: MoyaProvider<KastaAPI>
    var state = State.initialFetch
    
    // MARK: - NSObject
    
    init(provider: MoyaProvider<KastaAPI>) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported.")
    }
    
    // MARK: - UIViewController
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: false))
    
    lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .appBackground

        collectionView.backgroundColor = view.backgroundColor
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        fetch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: view.frame.height - UIApplication.shared.statusBarFrame.height)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - ListAdapterDataSource

extension ViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        switch self.state {
        case .success(items: let items):
            return items
        case .initialFetch, .failure(error: _):
            return []
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is SoonCampaigns:
            return SectionFactory.createSoonSectionController(viewController: self, object: object)
        default:
            return SectionFactory.createCampaignSectionController(viewController: self, object: object)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch state {
            
        case .initialFetch:
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            return activityIndicator
            
        case .failure(error: let error):
            let errorView = UIView(frame: CGRect(x: 16, y: view.frame.midY/2, width: view.frame.width - 32, height: 100))
            let label = UILabel()
            label.frame = CGRect(x: 16, y: 0, width: errorView.bounds.width, height: 70)
            label.center = errorView.center
            label.textAlignment = .center
            label.numberOfLines = 3
            label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
            label.textColor = .greyText
            
            let button = UIButton(type: .system)
            button.frame = CGRect(x: label.frame.origin.x, y: label.frame.maxY + 5, width: label.frame.width, height: label.frame.height)
            button.contentHorizontalAlignment = .center
            button.setTitle(NSLocalizedString("error.reload-button.title", comment: "Data fetch retry button title"), for: .normal)
            button.addTarget(self, action: #selector(retry), for: UIControlEvents.touchUpInside)
            
            switch (error as! MoyaError).errorDescription  {
            case "The Internet connection appears to be offline.":
                label.text = NSLocalizedString("error.connect.label.title", comment: "Data fetch error title")
            default:
                label.text = NSLocalizedString("error.decoding.label.title", comment: "Data fetch error title")
            }
            
            errorView.addSubview(label)
            errorView.addSubview(button)
            return errorView
            
        case .success(items: _):
            return nil
            
        }
    }
    
}

// MARK: - Fetch & process

extension ViewController {
    func fetch() {
        provider.request(.campaigns) { result in
            do {
                switch result {
                    
                case .success(let response):
                    let response = try response.filterSuccessfulStatusAndRedirectCodes()
                    var campaigns = try response.map([KastaAPI.Campaign].self, atKeyPath: "items", using: KastaAPI.Campaign.decoder)
                    campaigns = self.filterWithoutVirtual(campaigns: campaigns)
                    let (activeCampaigns, soonCampaigns, _) = campaigns.filterActiveWithSoon(for: Date())
                    var viewModels = activeCampaigns.map() { return Campaign(with: $0) } as [ListDiffable]
                    let soon = SoonCampaigns(with: soonCampaigns)
                    viewModels.insert(soon, at: 3)
                    self.state = .success(items: viewModels)
                    self.adapter.performUpdates(animated: true, completion: nil)
                    
                    
                case .failure(let error):
                    throw error
                }
                
            }
                
            catch let error {
                self.state = .failure(error: error)
                self.adapter.performUpdates(animated: true, completion: nil)

            }
        }
    }
    
    func filterWithoutVirtual(campaigns: [KastaAPI.Campaign]) -> [KastaAPI.Campaign] {
        return campaigns.filter{
            if let mods = $0.mods  {
                for mod in mods {
                    return mod["name"] != "virtual"
                }
            }
            return true
        }
    }
}

// MARK: – IGListSingleSectionControllerDelegate (item selection)
extension ViewController: ListSingleSectionControllerDelegate {
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        switch object {
        case is Campaign:
            let campaign = object as! Campaign
            if let webURL = URL(string: "https://modnakasta.ua/campaign/\(campaign.codename)/") {
                UIApplication.shared.openURL(webURL)
            }
        default:
            return
        }
    }
}

// MARK: - Actions

extension ViewController {
    @objc func retry() {
        state = .initialFetch
        fetch()
    }
}
