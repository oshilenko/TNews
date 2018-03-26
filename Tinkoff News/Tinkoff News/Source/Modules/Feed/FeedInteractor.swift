//
//  FeedInteractor.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 22.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedInteractorInput {
    func getFirstPage()
    func getNextPage()
}

protocol FeedInteractorOutput {
    func didGetFirstPage(news: [FeedItemViewModel])
    func didGetNextPage(news: [FeedItemViewModel])
    func didFailFirstPageWith(error: Error?)
    func didFailNextPageWith(error: Error?)
}

final class FeedInteractor: NSObject {
    // MARK: - Public variables
    var output: FeedInteractorOutput!
    var feedLoadService: FeedLoadService!
    
    // MARK: - Fileprivate variables
    fileprivate let pageCount: Int = 20
    fileprivate var news: [NewsShort] = []
}

// MARK: - FeedInteractorInput methods
extension FeedInteractor: FeedInteractorInput {
    func getFirstPage() {
        news.removeAll()
        feedLoadService.getFeedList(first: news.count, last: news.count + pageCount)
    }
    
    func getNextPage() {
        feedLoadService.getFeedList(first: news.count, last: news.count + pageCount)
    }
}

// MARK: - FeedLoadServiceOutput methods
extension FeedInteractor: FeedLoadServiceOutput {
    func requestFinishedWithSuccess(success: [NewsShort]) {
        let viewModels = convertToModels(news: success)
        news.isEmpty
            ? output.didGetFirstPage(news: viewModels)
            : output.didGetNextPage(news: viewModels)
        news.append(contentsOf: success)
    }
    
    func requestFinishedWithError(error: Error?) {
        news.isEmpty
            ? output.didFailFirstPageWith(error: error)
            : output.didFailNextPageWith(error: error)
    }
}

fileprivate extension FeedInteractor {
    func convertToModels(news: [NewsShort]) -> [FeedItemViewModel] {
        var viewModels: [FeedItemViewModel] = []
        
        news.forEach { (news) in
            if let id = news.id {
                var dateString: String?
                
                if var timeInterval = news.publicationDate?.milliseconds {
                    timeInterval = timeInterval / 1000
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM.dd.yyyy HH:mm:ss"
                    let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
                    dateString = dateFormatter.string(from: date)
                }
                
                viewModels.append(FeedItemViewModel(id: id, title: news.text, date: dateString))
            }
        }
        
        return viewModels
    }
}
