//
//  NewsPresenter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol NewsPresenterInput {
    // TODO
}

protocol NewsPresenterOutput {
    // TODO
}

final class NewsPresenter: NSObject {
    // MARK: - Public variables
    var output: NewsPresenterOutput!
    var interactor: NewsInteractorInput!
}

// MARK: - NewsPresenterInput methods
extension NewsPresenter: NewsPresenterInput {
    // TODO
}

// MARK: - NewsInteractorOutput methods
extension NewsPresenter: NewsInteractorOutput {
    // TODO
}
