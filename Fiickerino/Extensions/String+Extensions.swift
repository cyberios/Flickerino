//
//  String+Extensions.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "Ru_ru")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "dd MMMM"
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
    
    func formatTags(offset:Int = 1) -> [String]{
        var res:[String] = []
        res = self
            .split{$0.isWhitespace}
            .map{String($0)}
            .enumerated()
            .filter{$0.offset < offset}
            .map{$0.element}
        return res
    }
    
    func maxLength(length:Int = 20) -> String {
        var str = self
        let objcType = str as NSString
        if objcType.length >= length {
            str = objcType.substring(with:
                NSRange(
                 location: 0,
                 length: objcType.length > length
                    ? length : objcType.length)
            )
        }
        return  str
    }
}
