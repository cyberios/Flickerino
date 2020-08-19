//
//  ApiError.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//


import Foundation

struct BackendErrorResponse: Decodable {
    let errorCode: Int
    let errorMessage: String
    let errorFields: [ErrorField]?
    var detailCode: DetailErrorCodes? {
        return DetailErrorCodes(rawValue: errorCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "code"
        case errorMessage = "error_message"
        case errorFields = "field_errors"
    }
    
    enum DetailErrorCodes: Int {
        case Authentication = 4003
        case InvalidToken = 4002
    }
    
}

extension BackendErrorResponse {
    struct ErrorField: Decodable {
        let field: String
        let message: String
    }
}

enum APIError: Error {
    case decoding(DecodingError)
    case network(Error)
    case unacceptableStatusCode(code: Int, data: BackendErrorResponse?)
    case common
    case unknown(Error)
    
    var description: String {
        switch self {
        case .decoding(let error):
            return "Deserialization: \(error.localizedDescription)"
        case .network(let error):
            return "Network: \(error.localizedDescription)"
        case .unacceptableStatusCode(let code, let data):
            if let data = data {
                guard let fields = data.errorFields, fields.count > 1 else { return data.errorMessage }
                return fields.compactMap{ $0.field + ": " + $0.message}.joined(separator: ",\n" )
            } else {
                return "Status Code: \(code)"
            }
        default:
            return "Something wrong"
        }
    }
    
}
