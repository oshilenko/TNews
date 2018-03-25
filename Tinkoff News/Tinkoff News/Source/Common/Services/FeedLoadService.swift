//
//  FeedLoadService.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 25.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedLoadServiceInput {
    func getFeedList(first: Int, last: Int)
}

protocol  FeedLoadServiceOutput {
    func requestFinishedWithSuccess(success: [NewsShort])
    func requestFinishedWithError(error: Error?)
}

final class FeedLoadService: NSObject {
    // MARK: - Public variables
    var output: FeedLoadServiceOutput!
    
    // MARK: - Private variables
    private let requestManager: RequestManager = RequestManager()
    private var request: URLSessionDataTask?
}

// MARK: - FeedLoadServiceInput methods
extension FeedLoadService: FeedLoadServiceInput {
    func getFeedList(first: Int, last: Int) {
        let parameters: [String: Any] = ["first": first,
                                         "last" : last]
        let success = configureSuccessBlock()
        let failure = configureFailureBlock()
        request?.cancel()
        request = requestManager.requestObjects(method: .post,
                                               baseURL: Constants.URLs.baseUrl,
                                               path: Constants.URLs.Feed.getNews,
                                               parameters: parameters,
                                               success: success,
                                               failure: failure)
    }
}

// MARK: - Private variables
private extension FeedLoadService {
    func configureSuccessBlock() -> Success<[NewsShort]> {
        return { [weak self] news in
            self?.output.requestFinishedWithSuccess(success: news)
        }
    }
    
    func configureFailureBlock() -> Failure {
        return { [weak self] error in
            self?.output.requestFinishedWithError(error: error)
        }
    }
}
