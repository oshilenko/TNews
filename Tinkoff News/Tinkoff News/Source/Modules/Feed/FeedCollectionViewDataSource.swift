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
    func append(viewModels: [FeedItemViewModel])
}

protocol FeedCollectionViewDataSourceOutput {
    func didSelectItem(id: String)
}

final class FeedCollectionViewDataSource: NSObject {
    // MARK: - Public variables
    var output: FeedCollectionViewDataSourceOutput!
    
    // MARK: - Private variables
    private var viewModels: [FeedItemViewModel] = []
}

// MARK: - FeedCollectionViewDataSourceInput methods
extension FeedCollectionViewDataSource: FeedCollectionViewDataSourceInput {
    func set(viewModels: [FeedItemViewModel]) {
        self.viewModels = viewModels
    }
    
    func append(viewModels: [FeedItemViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
}

// MARK: - UICollectionViewDataSource methods
extension FeedCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: Constants.Cells.FeedItemCollectionViewCell.reuseIdentifier,
                                 for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedItemCollectionViewCell else { return }
        
        cell.date = viewModels[indexPath.item].date
        cell.title = viewModels[indexPath.item].title
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension FeedCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let title = viewModels[indexPath.item].title else { return .zero }
        
        return FeedItemCollectionViewCell.size(for: title)
    }
}

extension FeedCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(id: viewModels[indexPath.item].id)
    }
}
