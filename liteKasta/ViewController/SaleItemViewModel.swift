//
//  SaleViewModel.swift
//  liteKasta
//
//  Created by Serhii Bykov on 5/6/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import IGListKit

extension ViewController {
    class Sale: NSObject {
        let sales: [SaleItem]
        
        init(sales: [SaleItem]) {
            self.sales = sales
            super.init()
        }
    }
}

extension ViewController.Sale: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return sales.map({ $0.title.hashValue }).description.hashValue as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let o = object as? ViewController.Sale else {
            return false
        }
        return sales == o.sales
    }
}

extension ViewController {
    class SaleItem: NSObject {
        let title: String
        let desc: String
        
        init(title: String, desc: String) {
            self.title = title
            self.desc = desc
            super.init()
        }
    }
}

extension ViewController.SaleItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return title.hashValue as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let o = object as? ViewController.SaleItem else {
            return false
        }
        return title == o.title && desc == o.desc
    }
}
