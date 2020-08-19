//
//  SearchListResponce.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation

struct SearchListResponce:Decodable {
    let count:String
    let items:[SearchListItemResponce]
    
    enum CodingKeys:String, CodingKey{
        case photos
    }
    
    enum PhotoCodingKeys:String, CodingKey {
        case photo
        case count = "total"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photoContainer = try container.nestedContainer(keyedBy: PhotoCodingKeys.self, forKey: .photos)
        self.items = try photoContainer.decode([SearchListItemResponce].self,
                                               forKey: .photo)
        self.count = try photoContainer.decode(String.self, forKey: .count)
    }
}

struct SearchListItemResponce:Decodable{
    var photo_id:String
    var title:String
    var author:String
    var date:String
    var views:String
    var media:String
    var tags:String
    var img_url:String?
    
    enum CodingKeys:String, CodingKey{
        case photo_id = "id"
        case title
        case author = "ownername"
        case date = "datetaken"
        case views
        case img_url = "url_n"
        case media
        case tags
    }
}
