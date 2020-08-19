//
//  Mapper.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import RxSwift

struct EmptyResponse: Decodable {}

class Mapper<T: Decodable> {
    
    private let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    
    init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970) {
        self.dateDecodingStrategy = dateDecodingStrategy
    }
    
    typealias MappingResult = T
    
    func map(data: Data) -> Observable<T> {
        do {
            if MappingResult.self == EmptyResponse.self {
                return Observable.just(EmptyResponse() as! MappingResult)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy 
            let result = try decoder.decode(T.self, from: data)
            
            return Observable.just(result)
            
        }  catch let error as DecodingError {
            debug_Print("❗️ #### DECODE ERROR ####")
            debug_Print(error)
            return .error(APIError.decoding(error))
        } catch {
            return .error(APIError.unknown(error))
        }
    }
}
