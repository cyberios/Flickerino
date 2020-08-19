//
//  LoadingView.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
    
    var isLoading: Bool = false {
        didSet {
            self.isLoading ? showLoader() : hideLoader()
        }
    }
    
    let activityIndicator : UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView(style: .whiteLarge)
        actInd.color = Color.orange()
        actInd.isHidden = false
        actInd.startAnimating()
        return actInd
    }()
    
    let contenctView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = Color.lightBlueBackground()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupUI() {
        isHidden = true
        addSubview(contenctView)
        contenctView.addSubview(activityIndicator)
        contenctView.snp.makeConstraints{
            $0.center.equalTo(snp.center)
            $0.height.equalTo(64)
            $0.width.equalTo(64)
        }
        
        activityIndicator.snp.makeConstraints{
            $0.center.equalTo(contenctView.snp.center)
        }
    }
    
    private func showLoader() {
        superview?.bringSubviewToFront(self)
        isUserInteractionEnabled = false
        isHidden = false
    }
    
    private func hideLoader() {
        isUserInteractionEnabled = true
        isHidden = true
    }
    
}
