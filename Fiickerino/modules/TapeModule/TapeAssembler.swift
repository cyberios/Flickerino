//
//  TapeAssembler.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit

class TapeAssembler{
    static func createModule() -> UIViewController {
        let view = TapeViewController()
        let router = TapeRouter(view)
        let model = TapeViewModel(router: router)
        view.model = model
        return view
    }
}
