//
//  TapeViewController.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import IVCollectionKit
import RxSwift

class TapeViewController:BaseViewController{
    private lazy var director:CollectionDirector = CollectionDirector(colletionView:collectionView)
    
    private var tapeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let refreshContoller = UIRefreshControl()
        collectionView.refreshControl = refreshContoller
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let searchBar:UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        return controller
    }()
    
    var model:TapeViewModelProtocol!
    let headerSection = CollectionSection()
    let searchListSection = CollectionSection()
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.viewWillAppear()
        navigationItem.searchController = searchBar
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationItem.title = "Лента фотографий"
        collectionView.backgroundColor = Color.lightBlueBackground()
        
        searchBar.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = true
        
        view.insertSubview(collectionView, belowSubview: loadingView)
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        searchListSection.insetForSection = UIEdgeInsets(top: 16, left: 0, bottom: 25, right: 0)
        searchListSection.minimumInterItemSpacing = 8
        searchListSection.lineSpacing = 8
        director += headerSection
        director += searchListSection
    }
    
    override func bind() {
        super.bind()
        
        searchBar.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .bind(to: model.searchQuery)
            .disposed(by: disposeBag)
        
        model.filterList
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: {
                [weak self] model in
                
                defer { self?.director.reload() }
                self?.headerSection.removeAll()
                guard let self = self, let model = model else {
                    return
                }
                
                self.headerSection += CollectionItem<TapeHeaderCell>(item: model)
            })
            .disposed(by:disposeBag)
        
        model.searchList
            .asDriver(onErrorJustReturn: [])
            .drive(onNext:
                {[weak self] items in
                    defer { self?.director.performUpdates() }
                    self?.searchListSection.removeAll()
                    self?.searchListSection += items.map{ CollectionItem<TapeCell>(item: $0).onSelect { [weak self] item in
                        self?.model.tapAction.onNext(.didTapSelect(id: items[item.row].photo_id))
                        }
                    }
                }
            ).disposed(by: disposeBag)
        
        model.isLoading
            .map {[weak self] event in
                if self?.collectionView.refreshControl?.isRefreshing ?? false {
                    self?.collectionView.refreshControl?.endRefreshing()
                }
                return event
            }
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        if let refreshControl = collectionView.refreshControl {
            refreshControl.rx.controlEvent(.valueChanged)
                .bind(to: model.refreshObserver)
                .disposed(by: disposeBag)
        }
    }
}
