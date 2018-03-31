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
    private var refreshControl: UIRefreshControl!
    
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
    func refreshControlDidEndActive() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func updateCollectionViewItems(deleted: [IndexPath]?, inserted: [IndexPath]?, reload: [IndexPath]?) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.performBatchUpdates({
                self?.collectionView.deleteItems(at: deleted ?? [])
                self?.collectionView.insertItems(at: inserted ?? [])
                self?.collectionView.reloadItems(at: reload ?? [])
            }, completion: nil)
        }
    }
    
    func scrollToTop(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
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
        configureRefreshControll()
        configureCollectionView()
        registerCells()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.refreshControl = refreshControl
    }
    
    func configureRefreshControll() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(beginRefresh), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = Constants.Colors.brandYellow
    }
    
    
    @objc func beginRefresh() {
        presenter.refreshControllDidBeginActive()
    }
    
    func registerCells() {
        collectionView.register(Constants.Cells.FeedItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.FeedItemCollectionViewCell.reuseIdentifier)
        collectionView.register(Constants.Cells.PagingItemCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.PagingItemCollectionViewCell.reuseIdentifier)
        collectionView.register(Constants.Cells.EmptyStateCollectionViewCell.nib,
                                forCellWithReuseIdentifier: Constants.Cells.EmptyStateCollectionViewCell.reuseIdentifier)
    }
}

