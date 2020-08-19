//
//  DetailsViewController.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit

class DetailsViewController:BaseViewController {
    
    private lazy var labelView:UIView = {
        let v = UIView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        view.insertSubview(labelView, belowSubview: loadingView)
    }
    
    override func bind() {
        super.bind()
    }
}

