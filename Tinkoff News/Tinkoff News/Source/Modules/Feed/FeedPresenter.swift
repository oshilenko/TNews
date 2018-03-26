//
//  FeedPresenter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedPresenterInput {
    func viewDidLoad()
    func refreshControllDidBeginActive()
}

protocol FeedPresenterOutput {
    func reloadCollectionView()
    func refreshControlDidEndActive()
}

final class FeedPresenter: NSObject {
    // MARK: - Public variables
    var output:     FeedPresenterOutput!
    var interactor: FeedInteractorInput!
    var router:     FeedRouterInput!
    var dataSource: FeedCollectionViewDataSourceInput!
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
        dataSource.set(viewModels: news)
        output.refreshControlDidEndActive()
        output.reloadCollectionView()
    }
    
    func didGetNextPage(news: [FeedItemViewModel]) {
        dataSource.append(viewModels: news)
        output.reloadCollectionView()
    }
    
    func didFailFirstPageWith(error: Error?) {
        output.refreshControlDidEndActive()
        // TODO
    }
    
    func didFailNextPageWith(error: Error?) {
        // TODO
    }
}

// MARK: - FeedCollectionViewDataSourceOutput methods
extension FeedPresenter: FeedCollectionViewDataSourceOutput {
    func didSelectItem(id: String) {
        // TODO
    }
}
