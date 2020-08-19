//
//  SearchListModel.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation

struct SearchListCellModel:Hashable{
    let photo_id:String
    let author:String
    let title:String
    let views:String
    let date:String
    var image_url:String?
    var tags:[String]
    var media:String
    
    init(item:SearchListItemResponce) {
        photo_id = item.photo_id
        author = item.author
        title = item.title
        views = item.views
        date = SearchListCellModel.formatDate(dateString: item.date)
        image_url = item.img_url
        media = item.media
        tags = item.tags.formatTags(offset: 3)
    }
    
  
    private static func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            if Calendar.current.isDateInToday(date) {
                return "Добавлено сегодня"
            } else if Calendar.current.isDateInYesterday(date){
               return "Добавлено вчера"
            } else {
                return "Добавлено " + dateString.formatDate()
            }
        } else {
            return dateString
        }
    }
    
    
}

class TapeFlow {
    //var text: String = "Ocean"
    var currentOffset: Int = 0
    var searchQuery: String = "" {
        didSet {
            currentOffset = 1
        }
    }
    func nextPage() {
        currentOffset += 1
    }
    
}
