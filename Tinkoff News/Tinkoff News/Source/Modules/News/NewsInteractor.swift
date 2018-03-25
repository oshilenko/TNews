//
//  NewsInteractor.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol NewsInteractorInput {
    func getNewsContent(id: String)
}

protocol NewsInteractorOutput {
    // TODO
}

final class NewsInteractor: NSObject {
    var output: NewsInteractorOutput!
    var newsLoadService: NewsLoadService!
}

// MARK: - NewsInteractorInput methods
extension NewsInteractor: NewsInteractorInput {
    func getNewsContent(id: String) {
        newsLoadService.getNewsContent(id: id)
    }
}

// MARK: - NewsLoadServiceOutput methods
extension NewsInteractor: NewsLoadServiceOutput {
    func requestFinishedWithError(error: Error?) {
        // TODO
    }
    
    func requestFinishedWithSuccess(success: NewsContent) {
        // TODO
    }
}
