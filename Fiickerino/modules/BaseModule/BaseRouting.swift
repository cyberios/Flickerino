//
//  BaseRouting.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseRouter: BaseRouting {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

protocol BaseRouting: class {
    var viewController: UIViewController? { get }
    func showErrorMessage(_ error: APIError)
    //func showTopMessage( _ message: String, style: TopMessageView.Style)
    func dismiss()
    func popToRoot()
    func pop()
}

extension BaseRouting {
    func showErrorMessage(_ error: APIError) {
//        TopMessageViewPresenter.shared.showMessage(text: error.description, style: .warning)
    }
    
    //func showTopMessage( _ message: String, style: TopMessageView.Style = .success) {
        //TopMessageViewPresenter.shared.showMessage(text: message, style: style)
    //}
    
    func dismiss() {
        if let nvc = viewController?.navigationController {
            nvc.dismiss(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
    func popToRoot() {
        if let nvc = viewController?.navigationController {
            nvc.popToRootViewController(animated: true)
        }
    }

    func pop() {
        if let nvc = viewController?.navigationController {
            nvc.popViewController(animated: true)
        }
    }
}
