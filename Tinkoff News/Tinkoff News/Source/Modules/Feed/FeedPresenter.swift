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
}

protocol FeedPresenterOutput {
    // TODO
}

final class FeedPresenter: NSObject {
    // MARK: - Public variables
    var output:     FeedPresenterOutput!
    var interactor: FeedInteractorInput!
    var router:     FeedRouterInput!
}

// MARK: - FeedPresenterInput methods
extension FeedPresenter: FeedPresenterInput {
    func viewDidLoad() {
        interactor.getFeed(first: 0, last: 20)
    }
}

// MARK: - FeedInteractorOutput methods
extension FeedPresenter: FeedInteractorOutput {
    // TODO
}
