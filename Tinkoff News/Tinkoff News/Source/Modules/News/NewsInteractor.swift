//
//  NewsInteractor.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

enum NewsModelType {
    case header(id: String?, text: String?, date: String?)
    case dates(createDate: String?, modificationDate: String?)
    case content(text: String?)
}

protocol NewsInteractorInput {
    func getNewsContent(id: String)
}

protocol NewsInteractorOutput {
    func viewModelsDidChanged(viewModels: [NewsModelType])
}

final class NewsInteractor: NSObject {
    // MARK: - Public variables
    var output: NewsInteractorOutput!
    var newsLoadService: NewsLoadService!
    var dateFormatterService: DateFormatterService!
    
    // Fileprivate variables
    fileprivate var viewModels: [NewsModelType] = []
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
        let milliseconds = success.title?.publicationDate?.milliseconds
        let creationMilliseconds = success.creationDate?.milliseconds
        let modificationMilliseconds = success.lastModificationDate?.milliseconds
        
        let date = dateFormatterService
            .configureDateString(milliseconds: milliseconds, with: "dd MMMM yyyy")
        let creationDate = dateFormatterService
            .configureDateString(milliseconds: creationMilliseconds, with: "dd MMMM yyyy")
        let modificationDate = dateFormatterService
            .configureDateString(milliseconds: modificationMilliseconds, with: "dd MMMM yyyy")
        
        
        viewModels = [.header(id: success.title?.id, text: success.title?.text, date: date),
                      .dates(createDate: creationDate, modificationDate: modificationDate),
                      .content(text: success.content)]
        
        output.viewModelsDidChanged(viewModels: viewModels)
    }
}
