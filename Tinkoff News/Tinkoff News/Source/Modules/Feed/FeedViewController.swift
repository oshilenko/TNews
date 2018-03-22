//
//  FeedViewController.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 20.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    // MARK: - Public variables
    var presenter: FeedPresenterInput!
    
    // MARK: - Private variables
    private var configurator: FeedConfiguratorInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupConnection()
        configureViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - FeedPresenterOutput methods
extension FeedViewController: FeedPresenterOutput {
    // TODO
}

private extension FeedViewController {
    func setupConnection() {
        configurator = FeedConfigurator.create(controller: self)
        configurator.configureConnection()
    }
    
    func configureViewController() {
        // TODO
    }
}

