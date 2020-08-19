//
//  DetailsModule.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DetailsViewModelProtocol:class {
    // var isLoading:Driver<Bool> { get }
}

class DetailsViewModel:BaseViewModel {
    // var isLoading:Driver<Bool>
    override init() {
        
    }
}
extension DetailsViewModel:DetailsViewModelProtocol{
    
}
