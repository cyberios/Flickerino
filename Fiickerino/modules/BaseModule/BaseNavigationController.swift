//
//  BaseNavigationController.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit

//class BaseNavigationController: UINavigationController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//        setupUI()
//    }
//    
//    func setupUI() {
//        navigationBar.barTintColor = Color.background()
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = false
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.font:Font.sf(font: .SFUIText, weight: .semibold, size: 17)]
//    }
//
//    func configureTitleStyle(with style: NavigationControllerTitleStles) {
//        switch style {
//            case .normalTitles:
//                navigationBar.isTranslucent = false
//                navigationBar.titleTextAttributes = [NSAttributedString.Key.font:Font.sf(font: .SFUIText, weight: .semibold, size: 17)]
//            case .largeTitles:
//                navigationBar.isTranslucent = true
//                navigationBar.titleTextAttributes = nil
//                navigationBar.prefersLargeTitles = true
//                navigationItem.hidesSearchBarWhenScrolling = false
//        }
//    }
//    
//    enum NavigationControllerTitleStles {
//        case normalTitles
//        case largeTitles
//    }
//}
//
//extension BaseNavigationController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        item.tintColor = Color.text()
//        viewController.navigationItem.backBarButtonItem = item
//    }
//}
//
//
