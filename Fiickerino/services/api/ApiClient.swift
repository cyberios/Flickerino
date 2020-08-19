//
//  ApiClient.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import RxSwift
import Alamofire

struct NetworkResponse{
    let data:Data?
    let response: HTTPURLResponse
}

protocol ApiClientProtocol:class{
    func load(request:NetworkRequestParams & URLRequestConvertible) -> Observable<NetworkResponse>
    func loadMultipart(request: NetworkRequestParams & URLRequestConvertible) -> Observable<NetworkResponse>
}

class ApiClient:ApiClientProtocol{
    let session:Alamofire.Session
    
    init(session:Alamofire.Session = .default) {
        self.session = session
    }
    
    func load(request:NetworkRequestParams & URLRequestConvertible) -> Observable<NetworkResponse> {
        return Observable.create { [session] (observer) -> Disposable in
            let req = session.request(request).responseData(queue: DispatchQueue.global(qos: .utility)){
                (responce) in
                if let error = responce.error{
                    observer.onError(APIError.network(error))
                    return
                }
                
                if let resp = responce.response {
                    observer.onNext(NetworkResponse(data: responce.data, response: resp))
                    observer.onCompleted()
                }
                observer.onError(APIError.common)
            }
            return Disposables.create{
                req.cancel()
            }
        }
    }
    
    func loadMultipart(request: NetworkRequestParams & URLRequestConvertible) -> Observable<NetworkResponse> {
        guard let data = request.data else { return Observable.empty() }
        return Observable.create { [session] (observer) -> Disposable in
            let r = session.upload(multipartFormData: data, with: request).responseData(queue: DispatchQueue.global(qos: .utility)) { (response) in
                if let error = response.error {
                    observer.onError(APIError.network(error))
                    return
                }

                if let r = response.response {
                    observer.onNext(NetworkResponse(data: response.data, response: r))
                    observer.onCompleted()
                }

                observer.onError(APIError.common)
            }

            return Disposables.create {
                r.cancel()
            }
        }
    }
}

