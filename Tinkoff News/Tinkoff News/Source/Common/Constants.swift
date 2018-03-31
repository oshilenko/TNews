//
//  Constants.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 24.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    public struct Sizes {
        static public let navigationBarHeight: CGFloat = 64
    }
    
    public struct ServerErrorDescription {
        static public let unknown = "Что-то пошло не так, попробуйте повторить это действие позже"
        static public let noInternetConnection = "Не удалось загрузить новости, отсутсвует интернет соединение"
        static public let emptyData = "Ой, новости на сегодня закончились"
    }
    
    public struct ServerError {
        static public let unknown = NSError(domain: "unknown", code: 0)
        static public let jsonDecoding = NSError(domain: "JSONDecodingError", code: 0)
        static public let nilResponse = NSError(domain: "NilResponse", code: 0)
        static public let emptyData = NSError(domain: "EmptyData", code: 0)
    }
    
    public struct Session {
        static public let backgroundIdentifier = "com.shiko.tinkoff.news.background"
    }

    // MARK: - URLs
    public struct URLs {
        
        static public let baseUrl = "https://api.tinkoff.ru/"
        
        // MARK: - Feed
        public struct Feed {
            static public let getNews = "v1/news"
        }
        
        // MARK: - News
        public struct News {
            static public let getNewsContent = "v1/news_content"
        }
    }
    
    public struct Cells {
        public struct FeedItemCollectionViewCell {
            static public let reuseIdentifier: String = "FeedItemCollectionViewCellID"
            static public let nib: UINib = UINib(nibName: "FeedItemCollectionViewCell", bundle: nil)
        }
        
        public struct PagingItemCollectionViewCell {
            static public let reuseIdentifier: String = "PagingItemCollectionViewCellID"
            static public let nib: UINib = UINib(nibName: "PagingItemCollectionViewCell", bundle: nil)
            static public let height: CGFloat = 50
        }
        
        public struct EmptyStateCollectionViewCell {
            static public let reuseIdentifier: String = "EmptyStateCollectionViewCellID"
            static public let nib: UINib = UINib(nibName: "EmptyStateCollectionViewCell", bundle: nil)
        }
    }
    
    public struct Colors {
        static public let brandYellow: UIColor = UIColor(red: 255/256, green: 221/256, blue: 45/256, alpha: 1.0)
    }
    
}
