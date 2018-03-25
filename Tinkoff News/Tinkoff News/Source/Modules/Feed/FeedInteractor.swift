//
//  FeedInteractor.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedInteractorInput {
    func getFeed(first: Int, last: Int)
}

protocol FeedInteractorOutput {
    // TODO
}

final class FeedInteractor: NSObject {
    var output: FeedInteractorOutput!
    var feedLoadService: FeedLoadService!
}

// MARK: - FeedInteractorInput methods
extension FeedInteractor: FeedInteractorInput {
    func getFeed(first: Int, last: Int) {
        feedLoadService.getFeedList(first: first, last: last)
    }
}


extension FeedInteractor: FeedLoadServiceOutput {
    func requestFinishedWithSuccess() {
        // TODO
    }
    
    func requestFinishedWithError() {
        // TODO
    }
}
