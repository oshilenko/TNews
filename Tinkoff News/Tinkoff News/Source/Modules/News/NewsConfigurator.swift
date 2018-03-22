//
//  NewsConfigurator.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol NewsConfiguratorInput {
    func configureConnection()
}

final class NewsConfigurator: NSObject {
    // MARK: - Fileprivate varibales
    private var controller: NewsViewController!
    private let presenter:  NewsPresenter  = NewsPresenter()
    private let interactor: NewsInteractor = NewsInteractor()
    
    private override init() {
        super.init()
    }
    
    static func create(controller: NewsViewController) -> NewsConfigurator {
        let configurator = NewsConfigurator()
        configurator.controller = controller
        return configurator
    }
}

// MARK: - NewsConfiguratorInput methods
extension NewsConfigurator: NewsConfiguratorInput {
    func configureConnection() {
        configureController()
        configurePresenter()
        configureInteractor()
    }
}

// MARK: - Private methods
private extension NewsConfigurator {
    func configureController() {
        controller.presenter = presenter
    }
    
    func configurePresenter() {
        presenter.interactor = interactor
        presenter.output = controller
    }
    
    func configureInteractor() {
        interactor.output = presenter
    }
}
