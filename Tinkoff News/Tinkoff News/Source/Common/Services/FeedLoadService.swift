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
    func requestFinishedWithSuccess()
    func requestFinishedWithError()
}

final class FeedLoadService: NSObject {
    // MARK: - Public variables
    var output: FeedLoadServiceOutput!
    
    // MARK: - Private variables
    private let requestManager: RequestManager = RequestManager()
    private var request: URLSessionDataTask?
}

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

private extension FeedLoadService {
    func configureSuccessBlock() -> Success<[NewsShort]> {
        return { result in
            // TODO
        }
    }
    
    func configureFailureBlock() -> Failure {
        return { error in
            // TODO
        }
    }
}
