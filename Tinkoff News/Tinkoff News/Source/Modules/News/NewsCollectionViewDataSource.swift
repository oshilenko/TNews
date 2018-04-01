//
//  NewsCollectionViewDataSource.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 01.04.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation
import UIKit

protocol NewsCollectionViewDataSourceInput {
    func set(viewModels: [NewsModelType])
}

protocol NewsCollectionViewDataSourceOutput {
    func didSelectItem(id: String)
    func pagingIndicatorWillDisplay()
}

final class NewsCollectionViewDataSource: NSObject {
    // MARK: - Public variables
    var output: NewsCollectionViewDataSourceOutput!
    
    // MARK: - Private variables
    private var viewModels: [NewsModelType] = []
}

// MARK: - NewsCollectionViewDataSourceInput methods
extension NewsCollectionViewDataSource: NewsCollectionViewDataSourceInput {
    func set(viewModels: [NewsModelType]) {
        self.viewModels = viewModels
    }
}

// MARK: - UICollectionViewDataSource methods
extension NewsCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModels[indexPath.item] {
        case .header:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.Cells.HeaderItemCollectionViewCell.reuseIdentifier,
                                     for: indexPath)
            return cell
        case .dates:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.Cells.DateItemCollectionViewCell.reuseIdentifier,
                                     for: indexPath)
            return cell
        case .content:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.Cells.ContentItemCollectionViewCell.reuseIdentifier,
                                     for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch viewModels[indexPath.item] {
        case .header(_, let text, let date):
            guard let cell = cell as? HeaderItemCollectionViewCell else { return }
            
            cell.titleText = text
            cell.dateText = date
        case .dates(let createDate, let modificationDate):
            guard let cell = cell as? DateItemCollectionViewCell else { return }
            
            cell.creationDate = createDate
            cell.modificationDate = modificationDate
        case .content(let text):
            guard let cell = cell as? ContentItemCollectionViewCell else { return }
            
            cell.text = text
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension NewsCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModels[indexPath.item] {
        case .header(_, let text, _):
            guard let text = text else { return .zero }
            
            return HeaderItemCollectionViewCell.size(text: text)
        case .dates:
            return DateItemCollectionViewCell.size()
        case .content(let text):
            guard let text = text else { return .zero }
            
            return ContentItemCollectionViewCell.size(text: text)
        }
    }
}

// MARK: - UICollectionViewDelegate methods
extension NewsCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModels[indexPath.item] {
        case .header:
            break
        case .dates:
            break
        case .content:
            break
        }
    }
}
