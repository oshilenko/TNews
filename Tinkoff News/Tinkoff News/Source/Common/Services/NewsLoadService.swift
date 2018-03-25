//
//  NewsLoadService.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol NewsLoadServiceInput {
    func getNewsContent(id: String)
}

protocol  NewsLoadServiceOutput {
    func requestFinishedWithSuccess(success: NewsContent)
    func requestFinishedWithError(error: Error?)
}

final class NewsLoadService: NSObject {
    // MARK: - Public variables
    var output: NewsLoadServiceOutput!
    
    // MARK: - Private variables
    private let requestManager: RequestManager = RequestManager()
    private var request: URLSessionDataTask?
}

// MARK: - NewsLoadServiceInput methods
extension NewsLoadService: NewsLoadServiceInput {
    func getNewsContent(id: String) {
        let parameters: [String: Any] = ["id": id]
        let success = configureSuccessBlock()
        let failure = configureFailureBlock()
        request?.cancel()
        request = requestManager.requestObject(method: .post,
                                               baseURL: Constants.URLs.baseUrl,
                                               path: Constants.URLs.News.getNewsContent,
                                               parameters: parameters,
                                               success: success,
                                               failure: failure)
    }
}

// MARK: - Private methods
private extension NewsLoadService {
    func configureSuccessBlock() -> Success<NewsContent> {
        return { [weak self] newsContent in
            self?.output.requestFinishedWithSuccess(success: newsContent)
        }
    }
    
    func configureFailureBlock() -> Failure {
        return { [weak self] error in
            self?.output.requestFinishedWithError(error: error)
        }
    }
}
