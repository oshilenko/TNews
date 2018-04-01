//
//  DateItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class DateItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Public variables
    var creationDate: String?
    var modificationDate: String? {
        didSet {
            guard let text = modificationDate else { return }
            
            dateLabel.text = "Редакция от \(text)"
        }
    }

    @IBOutlet fileprivate weak var dateLabel: UILabel!
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = nil
    }
}

extension DateItemCollectionViewCell {
    static func size() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: Constants.Cells.DateItemCollectionViewCell.height)
    }
}
