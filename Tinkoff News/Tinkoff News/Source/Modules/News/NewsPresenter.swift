//
//  NewsPresenter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol NewsPresenterInput {
    func viewDidLoad()
}

protocol NewsPresenterOutput {
    func reloadCollectionView()
}

final class NewsPresenter: NSObject {
    // MARK: - Public variables
    var id:         String!
    var output:     NewsPresenterOutput!
    var interactor: NewsInteractorInput!
    var router:     NewsRouterInput!
    var dataSource: NewsCollectionViewDataSourceInput!
}

// MARK: - NewsPresenterInput methods
extension NewsPresenter: NewsPresenterInput {
    func viewDidLoad() {
        interactor.getNewsContent(id: id)
    }
}

// MARK: - NewsInteractorOutput methods
extension NewsPresenter: NewsInteractorOutput {
    func viewModelsDidChanged(viewModels: [NewsModelType]) {
        dataSource.set(viewModels: viewModels)
        output.reloadCollectionView()
    }
}
