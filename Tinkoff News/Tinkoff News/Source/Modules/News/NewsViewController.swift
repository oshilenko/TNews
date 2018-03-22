//
//  NewsViewController.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 20.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {
    // MARK: - Public variables
    var presenter: NewsPresenterInput!
    
    // MARK: - Private variables
    private var configurator: NewsConfiguratorInput!
    
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

// MARK: - NewsPresenterOutput methods
extension NewsViewController: NewsPresenterOutput {
    // TODO
}

private extension NewsViewController {
    func setupConnection() {
        configurator = NewsConfigurator.create(controller: self)
        configurator.configureConnection()
    }
    
    func configureViewController() {
        // TODO
    }
}

