//
//  DateItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class DateItemCollectionViewCell: UICollectionViewCell {
    
    var creationDate: String? {
        didSet {
            guard let text = creationDate else { return }
            
            firstLineDateLabel.text = text
        }
    }
    
    var modificationDate: String? {
        didSet {
            guard let text = modificationDate else { return }
            
            secondLineDateLabel.text = text
        }
    }

    @IBOutlet fileprivate weak var firstLineDateLabel: UILabel!
    @IBOutlet fileprivate weak var secondLineDateLabel: UILabel!
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        firstLineDateLabel.text = nil
        secondLineDateLabel.text = nil
    }
}

extension DateItemCollectionViewCell {
    static func size() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: Constants.Cells.DateItemCollectionViewCell.height)
    }
}
