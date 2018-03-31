//
//  PagingItemCollectionViewCell.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 31.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

class PagingItemCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.startAnimating()
    }
}

// MARK: - Public methods
extension PagingItemCollectionViewCell {
    static func size() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: Constants.Cells.PagingItemCollectionViewCell.height)
    }
}
