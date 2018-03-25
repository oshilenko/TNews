//
//  Constants.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 24.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

struct Constants {
    
    public struct ServerError {
        static public let unknown = NSError(domain: "unknown", code: 0)
        static public let JSONDecoding = NSError(domain: "JSONDecodingError", code: 0)
        static public let nilResponse = NSError(domain: "NilResponse", code: 0)
        static public let noInternetConnection = NSError(domain: "NoInternetConnection", code: 0)
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
    
}
