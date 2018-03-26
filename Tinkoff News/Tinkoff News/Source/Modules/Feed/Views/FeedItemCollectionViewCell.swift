//
//  FeedItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class FeedItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Public variables
    var title: String? {
        didSet {
            guard let title = title else { return }
            
            titleLabel.text = title
        }
    }
    
    var date: String? {
        didSet {
            guard let date = date else { return }
            
            dateLabel.text = date
        }
    }
    
    // MARK: - Fileprivate variables
    @IBOutlet fileprivate weak var titleLabel:  UILabel!
    @IBOutlet fileprivate weak var dateLabel:   UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Public static methods
extension FeedItemCollectionViewCell {
    static func size(for text: String) -> CGSize {
        let constCellHeight: CGFloat = 41
        let item: StringItemType = .feedItemTitle(text: text)
        let titleSize = item.size
        
        return CGSize(width: UIScreen.main.bounds.width,
                      height: titleSize.height + constCellHeight)
    }
}
