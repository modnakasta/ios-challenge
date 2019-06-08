//
//  ViewController.swift
//  liteKasta
//
//  Created by Zoreslav Khimich on 4/2/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit
import AlamofireImage

typealias activeAndSoonCampaigns = (active: [KastaAPI.Campaign], soon: [KastaAPI.Campaign])

class ViewController: UIViewController {
    
    let networkManager: NetworkManager // Actualy this should be in a Model, but - there's no time for MVC/MVVM stack :/
    var state = State.initialFetch {
        didSet {
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    // MARK: - NSObject
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported.")
    }
    
    // MARK: - UIViewController
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: false))
    
    lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        super.loadView() // Is this was forgotten on purpose?
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
        
        var controller: ListSingleSectionController!
        switch object {
        case is ViewController.SoonCampaign:
            controller = SoonCampaignCell.listSingleSectionController()
        case is ViewController.Campaign:
            controller = CampaignCell.listSingleSectionController()
        default:
            fatalError("This shouldn't happened")
        }
        guard case .success(let items) = state else {
            fatalError("Fetch state != .success, the collection should have no sections, yet the adapter requests one, wtf?")
        }
        
        controller.selectionDelegate = self
        
        let currentItem = object as! ListDiffable
        let isFirstItem = currentItem.isEqual(toDiffableObject: items.first)
        
        controller.inset = UIEdgeInsets(top: isFirstItem ? 32 : 0, left: 16, bottom: 16, right: 16)
        
        return controller
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch state {
            
        case .initialFetch:
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            return activityIndicator
            
        case .failure(error: _):
            let button = UIButton(type: .system)
            button.setTitle(NSLocalizedString("error.reload-button.title", comment: "Data fetch retry button title"), for: .normal)
            button.addTarget(self, action: #selector(retry), for: UIControlEvents.touchUpInside)
            return button
            
        case .success(items: _):
            return nil
            
        }
    }
    
}

// MARK: - Fetch & process

extension ViewController {
    func fetch() {
        // cause working with network in VC isn't the best decision (:
        networkManager.fetch { [weak self] (campaings, error)  in
            if let error = error {
                self?.state = .failure(error: error)
            } else if let campaings = campaings {
                
                let activeCampaigns: [ListDiffable] = campaings.active.map() { return ViewController.Campaign(with: $0) }
                var viewModels = activeCampaigns

                if !campaings.soon.isEmpty { // There might be no soon campaigns
                    let soonCampaing = ViewController.SoonCampaign(with: campaings.soon)
                    
                    if viewModels.count > 3 {
                        viewModels.insert(soonCampaing, at: 3)
                    } else {
                        viewModels.append(soonCampaing)
                    }
                }
                
                self?.state = .success(items: viewModels)
            } else {
                fatalError("This shouldn't happened")
            }
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
