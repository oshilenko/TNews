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
    var id: String!
    var presenter: NewsPresenterInput!
    var dataSource: NewsCollectionViewDataSource!
    
    // MARK: - Private variables
    private var configurator: NewsConfiguratorInput!
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    // MARK: - Public methods
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
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Fileprivate methods
private extension NewsViewController {
    func setupConnection() {
        configurator = NewsConfigurator.create(controller: self)
        configurator.configureConnection()
        presenter.viewDidLoad()
    }
    
    func configureViewController() {
        configureCollectionView()
        registerCells()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
    
    func registerCells() {
        collectionView.register(Constants.Cells.HeaderItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.HeaderItemCollectionViewCell.reuseIdentifier)
        collectionView.register(Constants.Cells.DateItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.DateItemCollectionViewCell.reuseIdentifier)
        collectionView.register(Constants.Cells.ContentItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.ContentItemCollectionViewCell.reuseIdentifier)
    }
}

extension NewsViewController {
    static func create(id: String) -> NewsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewsViewControllerID")
        (controller as? NewsViewController)?.id = id
        
        return controller as? NewsViewController
    }
}

