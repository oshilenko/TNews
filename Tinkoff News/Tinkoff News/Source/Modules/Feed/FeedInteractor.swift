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
    func didGetData(news: [FeedItemViewModel])
    func didFailWith(error: Error?)
}

final class FeedInteractor: NSObject {
    // MARK: - Public variables
    var output: FeedInteractorOutput!
    var feedLoadService: FeedLoadService!
    
    // MARK: - Fileprivate variables
    fileprivate var news: [NewsShort] = []
}

// MARK: - FeedInteractorInput methods
extension FeedInteractor: FeedInteractorInput {
    func getFeed(first: Int, last: Int) {
        feedLoadService.getFeedList(first: first, last: last)
    }
}

// MARK: - FeedLoadServiceOutput methods
extension FeedInteractor: FeedLoadServiceOutput {
    func requestFinishedWithSuccess(success: [NewsShort]) {
        news = success
        let viewModels = convertToModels(news: news)
        output.didGetData(news: viewModels)
    }
    
    func requestFinishedWithError(error: Error?) {
        output.didFailWith(error: error)
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
