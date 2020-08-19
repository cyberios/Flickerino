//
//  RequestValidator.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import Foundation
import RxSwift


protocol RequestValidatorProtocol:class{
    func validate(response:NetworkResponse) -> Observable<Data>
}

class RequestValidator:RequestValidatorProtocol{
    func validate(response: NetworkResponse) -> Observable<Data> {
        switch response.response.statusCode {
            case 204:
                if response.data != nil {
                    fallthrough
                } else if let data = "{}".data(using: .utf8){
                    return Observable.just(data)
                } else {
                    return Observable.error(APIError.common)
            }
            case 200...205:
                guard let data = response.data else {
                    return Observable.just(Data())
                }
        
                return Observable.just(data)
            default:
                guard let data = response.data else {
                    return Observable.error(APIError.unacceptableStatusCode(code: response.response.statusCode, data: nil))
                }
                debug_Print("🛑", String(data: data, encoding: .utf8) ?? "some wrong")
                return Observable.error(APIError.unacceptableStatusCode(code: response.response.statusCode,
                    data: try? JSONDecoder().decode(BackendErrorResponse.self, from: data)))
            }
    }
}
