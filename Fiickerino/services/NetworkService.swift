//
//  NetworkService.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Alamofire
import RxSwift

enum SearchNetworkRouter:NetworkRequestParams & URLRequestConvertible{
    case searchList(text:String, page:Int)
    var path: String {
        return ""
    }

    var method: HTTPMethod {
        switch self {
        case .searchList:
            return .get
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .searchList(let text, let page):
            return [
                "tags": text,
                "api_key": ConfigurationManager.shared.apiToken,
                "method":"flickr.photos.search",
                "extras":"url_n, owner_name, date_taken, views, media, tags",
                "format":"json",
                "nojsoncallback":1,
                "per-page": 20,
                "page": page,
                "sort": "relevance",
                "content_type": 1
            ]
        
        }
    }

}

enum DetailsNetworkRouter:NetworkRequestParams & URLRequestConvertible{
    case details
    var path: String {
        return ""
    }

    var method: HTTPMethod {
        switch self {
        case .details:
            return .get
        }
    }


}


protocol SearchNetworkServiceProtocol:class {
    func search(text:String, page: Int) -> Observable<SearchListResponce>
}

class SearchNetworkService:SearchNetworkServiceProtocol{
    func search(text: String, page: Int) -> Observable<SearchListResponce> {
        return DataRequest<SearchListResponce>().load(request:
            SearchNetworkRouter.searchList(text: text, page: page))
    }
}
