//
//  FeedCollectionViewDataSource.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation
import UIKit

final class FeedItemViewModel {
    var id: String
    var title: String?
    var date: String?
    
    init(id: String, title: String?, date: String?) {
        self.id     = id
        self.title  = title
        self.date   = date
    }
}

protocol FeedCollectionViewDataSourceInput {
    func set(viewModels: [FeedItemViewModel])
    func set(presentedItems: [FeedPresentedItems])
    func append(viewModels: [FeedItemViewModel])
    func getIndexPath(for items: [FeedItemViewModel]) -> [IndexPath]
    func getPagingItemIndex() -> [IndexPath]?
}

protocol FeedCollectionViewDataSourceOutput {
    func didSelectItem(id: String)
    func pagingIndicatorWillDisplay()
}

final class FeedCollectionViewDataSource: NSObject {
    // MARK: - Public variables
    var output: FeedCollectionViewDataSourceOutput!
    
    // MARK: - Private variables
    private var viewModels: [FeedItemViewModel] = []
    private var presentedItems: [FeedPresentedItems] = []
}

// MARK: - FeedCollectionViewDataSourceInput methods
extension FeedCollectionViewDataSource: FeedCollectionViewDataSourceInput {
    func set(viewModels: [FeedItemViewModel]) {
        self.viewModels = viewModels
    }
    
    func set(presentedItems: [FeedPresentedItems]) {
        self.presentedItems = presentedItems
    }
    
    func append(viewModels: [FeedItemViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
    
    func getIndexPath(for items: [FeedItemViewModel]) -> [IndexPath] {
        var index: Int = 0
        var indexPaths: [IndexPath] = []
        
        viewModels.forEach { (model) in
            if items.contains(where: { $0.id == model.id }) {
                indexPaths.append(IndexPath(item: index, section: 0))
            }
            index += 1
        }
        
        return indexPaths
    }
    
    func getPagingItemIndex() -> [IndexPath]? {
        guard let index = presentedItems.index(where: { $0 == .indicator }) else { return nil }
        
        return [IndexPath(item: index, section: 0)]
    }
}

// MARK: - UICollectionViewDataSource methods
extension FeedCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch presentedItems[indexPath.item] {
        case .item:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.Cells.FeedItemCollectionViewCell.reuseIdentifier,
                                     for: indexPath)
            return cell
        case .indicator:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.Cells.PagingItemCollectionViewCell.reuseIdentifier,
                                     for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch presentedItems[indexPath.item] {
        case .item:
            guard let cell = cell as? FeedItemCollectionViewCell else { return }
            
            cell.date = viewModels[indexPath.item].date
            cell.title = viewModels[indexPath.item].title
        case .indicator:
            output.pagingIndicatorWillDisplay()
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension FeedCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch presentedItems[indexPath.item] {
        case .item:
            guard let title = viewModels[indexPath.item].title else { return .zero }
            
            return FeedItemCollectionViewCell.size(for: title)
        case .indicator:
            return PagingItemCollectionViewCell.size()
        }
    }
}

// MARK: - UICollectionViewDelegate methods
extension FeedCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presentedItems[indexPath.item] {
        case .item:
            output.didSelectItem(id: viewModels[indexPath.item].id)
        case .indicator:
            break
        }
    }
}
