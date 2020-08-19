//
//  BaseViewController.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    lazy var loadingView = LoadingView()
    
    let disposeBag = DisposeBag()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    func bind() {}
    func setupUI() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

extension Reactive where Base: BaseViewController {
    var isLoading: Binder<Bool> {
        return Binder(self.base) { (base, isLoading) in
            base.loadingView.isLoading = isLoading
        }
    }
}
