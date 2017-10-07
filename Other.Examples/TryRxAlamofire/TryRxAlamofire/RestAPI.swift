//
//  RestAPI.swift
//  TryRxAlamofire
//
//  Created by Olarn U. on 6/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

enum Result {
    case success
    case error
}

class RestAPI {
    
    func request(url: String) -> Observable<(Result, Any)> {
        return Observable<String>.just(url)
            .flatMap { RxAlamofire.requestJSON(.get, $0) }
            .share()
            .flatMap { response -> Observable<(Result, Any)> in
                if 200..<300 ~= response.0.statusCode {
                    return Observable.just((Result.success, response.1))
                } else {
                    return Observable.just((Result.error, response.1))
                }
        }
    }
    
}
