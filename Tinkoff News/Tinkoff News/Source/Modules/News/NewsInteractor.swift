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
    case content(text: NSAttributedString?)
    case emptyState(text: String)
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
        var emptyStateString = Constants.ServerErrorDescription.unknown
        
        if let error = error {
            if error._code == NSURLErrorNetworkConnectionLost || error._code == NSURLErrorTimedOut {
                emptyStateString = Constants.ServerErrorDescription.noInternetConnectionNews
            } else if error._domain == Constants.ServerError.emptyData.domain {
                emptyStateString = Constants.ServerErrorDescription.emptyDataNews
            }
        }
        
        viewModels = [.emptyState(text: emptyStateString)]
        output.viewModelsDidChanged(viewModels: viewModels)
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
            .configureDateString(milliseconds: modificationMilliseconds, with: "dd.MM.yyyy")
        
        var attributedContent: NSAttributedString?
        if let html = success.content {
            let attrStr = convertToAttributedString(html: html)
            attributedContent = attrStr == nil ? NSAttributedString(string: html) : attrStr
        }
        
        viewModels = [.header(id: success.title?.id, text: success.title?.text, date: date),
                      .dates(createDate: creationDate, modificationDate: modificationDate),
                      .content(text: attributedContent)]
        
        output.viewModelsDidChanged(viewModels: viewModels)
    }
}

fileprivate extension NewsInteractor {
    func convertToAttributedString(html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        
        return try? NSAttributedString(data: data,
                                       options: [.documentType : NSAttributedString.DocumentType.html,
                                                 .characterEncoding: String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }
}
