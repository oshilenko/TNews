//
//  FeedConfigurator.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedConfiguratorInput {
    func configureConnection()
}

final class FeedConfigurator: NSObject {
    // MARK: - Fileprivate varibales
    private var controller: FeedViewController!
    private let presenter:  FeedPresenter  = FeedPresenter()
    private let interactor: FeedInteractor = FeedInteractor()
    private let router:     FeedRouter     = FeedRouter()
    
    private let dataSource: FeedCollectionViewDataSource = FeedCollectionViewDataSource()
    private let feedLoadService: FeedLoadService = FeedLoadService()
    
    private override init() {
        super.init()
    }
    
    static func create(controller: FeedViewController) -> FeedConfigurator {
        let configurator = FeedConfigurator()
        configurator.controller = controller
        return configurator
    }
}

// MARK: - FeedConfiguratorInput methods
extension FeedConfigurator: FeedConfiguratorInput {
    func configureConnection() {
        configureController()
        configurePresenter()
        configureInteractor()
        configureFeedLoadService()
        configureCollectionViewDataSource()
    }
}

// MARK: - Private methods
private extension FeedConfigurator {
    func configureController() {
        controller.presenter = presenter
        controller.dataSource = dataSource
    }
    
    func configurePresenter() {
        presenter.interactor = interactor
        presenter.output     = controller
        presenter.router     = router
        presenter.dataSource = dataSource
    }
    
    func configureInteractor() {
        interactor.output = presenter
        interactor.feedLoadService = feedLoadService
    }
    
    func configureFeedLoadService() {
        feedLoadService.output = interactor
    }
    
    func configureCollectionViewDataSource() {
        dataSource.output = presenter
    }
}
