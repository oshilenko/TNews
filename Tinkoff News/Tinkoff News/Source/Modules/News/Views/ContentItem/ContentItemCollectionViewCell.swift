//
//  ContentItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class ContentItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Public variables
    var text: NSAttributedString? {
        didSet {
            guard let text = text else { return }
            
            textLabel.attributedText = text
        }
    }

    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var textLabel: UILabel!
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel.text = nil
    }
}

// MARK: - Public methods
extension ContentItemCollectionViewCell {
    static func size(text: NSAttributedString) -> CGSize {
        let item: StringItemType = .newsContentItemTitle(text: text)
        return CGSize(width: UIScreen.main.bounds.width, height: item.size.height + 20)
    }
}
