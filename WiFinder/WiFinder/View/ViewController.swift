//
//  ViewController.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit
import RxSwift
import RxSwiftUtilities
import RxCocoa
import SDWebImage
import AVFoundation
import AVKit


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            tableView.backgroundView = activityIndicatorView
            tableView.separatorStyle = .none
        }
    }
    
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "mediaCell"
    private var viewModel: SearchViewMovel?
    
    let playerViewController = AVPlayerViewController()
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchController.searchBar.barStyle = .black
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureProperties()
        configureSearchBar()
        configureBindings()
    }
    
    private func configureProperties() {
        navigationItem.searchController = searchController
        navigationItem.title = "WiFinder"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    private func configureSearchBar() {
        searchController.searchBar.scopeButtonTitles = ["Movies", "Music", "TV Shows"]
        searchController.searchBar.showsScopeBar = true
    }
    
    private func configureBindings() {
        viewModel = SearchViewMovel()
        guard let viewModel = viewModel else { return }
        
        NotificationCenter.default.rx.notification(Notification.Name.AVPlayerItemDidPlayToEndTime)
            .asObservable().subscribe({ [unowned self] notification in
                self.playerViewController.player?.pause()
                self.playerViewController.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.selectedScopeButtonIndex
            .bind(to: viewModel.searchScopeIndex)
            .disposed(by: disposeBag)
        
        viewModel.loadingIndicator
            .asObservable()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.searchDidFinish?.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: MediaCell.self)) {
            (index, model, cell: MediaCell) in
            cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MediaItem.self)
            .subscribe(onNext: { [unowned self]  model in
                print(model.previewUrl)
                guard let videoURL = URL(string: model.previewUrl) else { return }
                let player = AVPlayer(url: videoURL)
                self.playerViewController.player = player
                
                if self.searchController.isActive {
                    self.searchController.isActive = false
                }
                
                self.navigationController?.present(self.playerViewController, animated: true) {
                    self.playerViewController.player?.play()
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


