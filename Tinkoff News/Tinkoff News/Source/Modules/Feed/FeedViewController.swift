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
    var dataSource: FeedCollectionViewDataSource!
    
    // MARK: - Private variables
    private var configurator: FeedConfiguratorInput!
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
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
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Private methods
private extension FeedViewController {
    func setupConnection() {
        configurator = FeedConfigurator.create(controller: self)
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
        collectionView.register(Constants.Cells.FeedItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.FeedItemCollectionViewCell.reuseIdentifier)
    }
}

