//
//  FeedRouter.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 23.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

protocol FeedRouterInput {
    func openNewsContent(id: String)
}

final class FeedRouter: NSObject {
    
}

// MARK: - FeedRouterInput methods
extension FeedRouter: FeedRouterInput {
    func openNewsContent(id: String) {
        // TODO
    }
}
