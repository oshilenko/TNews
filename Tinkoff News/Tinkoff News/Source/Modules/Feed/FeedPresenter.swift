//
//  FeedPresenter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedPresenterInput {
    // TODO
}

protocol FeedPresenterOutput {
    // TODO
}

final class FeedPresenter: NSObject {
    // MARK: - Public variables
    var output: FeedPresenterOutput!
    var interactor: FeedInteractorInput!
}

// MARK: - FeedPresenterInput methods
extension FeedPresenter: FeedPresenterInput {
    // TODO
}

// MARK: - FeedInteractorOutput methods
extension FeedPresenter: FeedInteractorOutput {
    // TODO
}
