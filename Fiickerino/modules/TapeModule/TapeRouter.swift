//
//  TapeRouter.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit


protocol TapeRouterProtocol:class {
    func showDetails(with id: String)
}

class TapeRouter:BaseRouter {
}

extension TapeRouter:TapeRouterProtocol {
    func showDetails(with id: String){
        let details = DetailsAssembler.createModule(id: id)
        let nvc = UINavigationController(rootViewController: details)
        //nvc.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.present(nvc, animated: true)
        //viewController?.navigationController?.pushViewController(nvc, animated: true)
    }
}
