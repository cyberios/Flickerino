//
//  NetworkUtils.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//
import Foundation
import Alamofire

protocol NetworkRequestParams {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var defaultHeaders: HTTPHeaders? { get }
    var data: MultipartFormData? { get }
}

extension NetworkRequestParams {
    var baseUrl: URL {
        let baseUri = ConfigurationManager.shared.apiURL
        guard let url = URL(string: baseUri) else {
            return URL(string: "error")!
        }
        return url
    }

    var encoding: ParameterEncoding {
        return URLEncoding()
    }

    var headers: HTTPHeaders? {
        return defaultHeaders
    }

    var parameters: Parameters {
        return [:]
    }

    var defaultHeaders: HTTPHeaders? {
        return nil
    }

    var data: MultipartFormData? {
        return nil
    }

}

extension URLRequestConvertible where Self:NetworkRequestParams  {
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        //TODO: merge defaultHeaders and headers?
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 60
        return try encoding.encode(request, with: parameters)
    }
}




