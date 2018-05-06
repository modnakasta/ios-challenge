//
//  SaleCell.swift
//  liteKasta
//
//  Created by Serhii Bykov on 5/6/18.
//  Copyright © 2018 Markason LLC. All rights reserved.
//

import UIKit

extension ViewController {
    class SaleItemView: UIView {
        let title = UILabel()
        let desc = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .campaignCellBackground
            isOpaque = true
            
            title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            title.textColor = .saleTitleText
            addSubview(title)
            
            desc.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            desc.textColor = .saleDescriptionText
            addSubview(desc)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("Not supported")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            title.frame = CGRect(x: 16, y: 8, width: bounds.width - 32, height: 22)
            desc.frame = CGRect(x: 16, y: 32, width: bounds.width - 32, height: 18)
        }
    }
}

extension ViewController {
    class SaleCell: UICollectionViewCell {
        let header = UILabel()
        let footer = UIButton()
        let items = [SaleItemView(), SaleItemView(), SaleItemView()]
        
        static let height: CGFloat = 282.0
        
        var upcomingSalesButtonClick: (() -> Void)? = nil
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .campaignCellBackground
            isOpaque = true
            
            layer.cornerRadius = 4.0
            
            header.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            header.textColor = .subtitledText
            header.text = NSLocalizedString("text.soon-on-sale-label.title", comment: "Soon on sale label text").uppercased()
            addSubview(header)
            
            footer.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            footer.contentHorizontalAlignment = .left
            footer.setTitleColor(.saleButtonText, for: .normal)
            footer.setTitle(NSLocalizedString("text.all-upcoming-sales-button.title", comment: "All upcoming sales button text"), for: .normal)
            footer.addTarget(self, action: #selector(upcomingSalesButtonTap), for: .touchUpInside)
            addSubview(footer)
            
            for item in items {
                item.isHidden = true
                addSubview(item)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("Not supported")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            header.frame = CGRect(x: 16, y: 16, width: bounds.width - 32, height: 18)
            footer.frame = CGRect(x: 16, y: bounds.height - 32, width: bounds.width - 32, height: 18)
            
            for (i, item) in items.enumerated() {
                item.frame = CGRect(x: 0.0, y: Double(header.frame.origin.y + header.frame.height) + 8.0 + 64.0 * Double(i), width: Double(frame.width), height: 64.0)
            }
        }
        
        @objc private func upcomingSalesButtonTap() {
            upcomingSalesButtonClick?()
        }
    }
}

extension ViewController.SaleCell {
    func setup(with sale: ViewController.Sale) {
        for (it, saleItem) in sale.sales.enumerated() {
            if it > items.count - 1 { return }
            items[it].isHidden = false
            items[it].title.text = saleItem.title
            items[it].desc.text = saleItem.desc
        }
    }
}
