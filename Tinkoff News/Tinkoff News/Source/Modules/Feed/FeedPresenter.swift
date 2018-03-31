//
//  FeedPresenter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

enum FeedPresentedItems {
    case item
    case indicator
}

protocol FeedPresenterInput {
    func viewDidLoad()
    func refreshControllDidBeginActive()
}

protocol FeedPresenterOutput {
    func reloadCollectionView()
    func refreshControlDidEndActive()
    func updateCollectionViewItems(deleted: [IndexPath]?, inserted: [IndexPath]?, reload: [IndexPath]?)
}

final class FeedPresenter: NSObject {
    // MARK: - Public variables
    var output:     FeedPresenterOutput!
    var interactor: FeedInteractorInput!
    var router:     FeedRouterInput!
    var dataSource: FeedCollectionViewDataSourceInput!
    
    // MARK: - Fileprivate variables
    fileprivate var presentedItems: [FeedPresentedItems] = []
}

// MARK: - FeedPresenterInput methods
extension FeedPresenter: FeedPresenterInput {
    func refreshControllDidBeginActive() {
        interactor.getFirstPage()
    }
    
    func viewDidLoad() {
        interactor.getFirstPage()
    }
}

// MARK: - FeedInteractorOutput methods
extension FeedPresenter: FeedInteractorOutput {
    func didGetFirstPage(news: [FeedItemViewModel]) {
        presentedItems = []
        presentedItems = news.flatMap({ _ in return .item })
        presentedItems.append(.indicator)
        
        dataSource.set(presentedItems: presentedItems)
        dataSource.set(viewModels: news)
        
        output.refreshControlDidEndActive()
        output.reloadCollectionView()
    }
    
    func didGetNextPage(news: [FeedItemViewModel]) {
        let deleted = dataSource.getPagingItemIndex()
        presentedItems = presentedItems.flatMap({ return $0 == .indicator ? nil : $0 })
        presentedItems.append(contentsOf: news.flatMap({ _ in return .item }))
        presentedItems.append(.indicator)
        
        dataSource.set(presentedItems: presentedItems)
        dataSource.append(viewModels: news)
        var inserted = dataSource.getIndexPath(for: news)
        
        if let pagingIndexPath = dataSource.getPagingItemIndex()?.first {
            inserted.append(pagingIndexPath)
        }
        
        output.updateCollectionViewItems(deleted: deleted, inserted: inserted, reload: nil)
    }
    
    func didFailFirstPageWith(error: Error?) {
        presentedItems = []
        output.refreshControlDidEndActive()
        // TODO: error
    }
    
    func didFailNextPageWith(error: Error?) {
        // TODO: remove indicator, scroll to last item
    }
}

// MARK: - FeedCollectionViewDataSourceOutput methods
extension FeedPresenter: FeedCollectionViewDataSourceOutput {
    func didSelectItem(id: String) {
        // TODO
    }
    
    func pagingIndicatorWillDisplay() {
        interactor.getNextPage()
    }
}
