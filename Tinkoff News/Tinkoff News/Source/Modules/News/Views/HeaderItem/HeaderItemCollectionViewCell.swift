//
//  HeaderItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class HeaderItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Public varibales
    var titleText: String? {
        didSet {
            guard let text = titleText else { return }
            
            titleLabel.text = text
        }
    }
    
    var dateText: String? {
        didSet {
            guard let text = dateText else { return }
            
            dateLabel.text = text
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = nil
        titleLabel.text = nil
    }
}

// MARK: - Public methods
extension HeaderItemCollectionViewCell {
    static func size(text: String) -> CGSize {
        let constCellHeight: CGFloat = 40
        let item: StringItemType = .newsHeaderItemTitle(text: text)
        let titleSize = item.size
        
        return CGSize(width: UIScreen.main.bounds.width,
                      height: titleSize.height + constCellHeight)
    }
}
