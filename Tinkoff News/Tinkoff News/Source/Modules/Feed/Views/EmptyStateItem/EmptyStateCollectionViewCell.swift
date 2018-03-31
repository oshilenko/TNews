//
//  EmptyStateCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class EmptyStateCollectionViewCell: UICollectionViewCell {

    var text: String! {
        didSet {
            textLabel.text = text
        }
    }
    
    @IBOutlet fileprivate weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension EmptyStateCollectionViewCell {
    static func size() -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - Constants.Sizes.navigationBarHeight
        
        return CGSize(width: width, height: height)
    }
}
