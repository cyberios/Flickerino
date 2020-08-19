//
//  debug_print.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation

@inline(__always)
func debug_Print(_ items: Any...){
    if ConfigurationManager.shared.activeConfiguration == .debug {
        print(items)
    }
}
