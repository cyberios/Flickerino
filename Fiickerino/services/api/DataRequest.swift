//
//  DataRequest.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import RxSwift
import Alamofire

class DataRequest<T:Decodable>{
    
    typealias RequestType = T
    private let client:ApiClientProtocol
    private let validator:RequestValidatorProtocol
    private let mapper:Mapper<RequestType>
    
    init(client:ApiClient = ApiClient(),
         validator:RequestValidatorProtocol = RequestValidator(),
         mapper:Mapper<RequestType> = Mapper()) {
        
        self.client = client
        self.validator = validator
        self.mapper = mapper
    }
    
    func load(request:NetworkRequestParams & URLRequestConvertible) -> Observable<RequestType>{
        return client.load(request:request)
            .flatMapLatest(validator.validate)
            .flatMapLatest(mapper.map)
    }
    
    func loadMultiPart(request:NetworkRequestParams & URLRequestConvertible) -> Observable<RequestType>{
        return client.loadMultipart(request:request)
            .flatMapLatest(validator.validate)
            .flatMapLatest(mapper.map)
    }
}

