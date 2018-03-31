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
    var feed: FeedViewController!
}

// MARK: - FeedRouterInput methods
extension FeedRouter: FeedRouterInput {
    func openNewsContent(id: String) {
        guard let controller = NewsViewController.create(id: id) else { return }
        
        feed.navigationController?.pushViewController(controller, animated: true)
    }
}
