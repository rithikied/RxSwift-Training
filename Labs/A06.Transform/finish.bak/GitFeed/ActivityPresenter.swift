//
//  ActivityPresenter.swift
//  GitFeed
//
//  Created by Olarn U. on 28/9/2560 BE.
//  Copyright © 2560 Underplot ltd. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ActivityPresenter {
    
    let bag = DisposeBag()
    
    func fetchEvents(repo: String) -> Observable<[Event]> {
        return Observable.just(repo)
            .map { URL(string: "https://api.github.com/repos/\($0)/events")! }
            .map { URLRequest(url: $0) }
            .flatMap { request -> Observable<(HTTPURLResponse, Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .shareReplay(1)
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = jsonObject as? [[String: Any]] else {
                        return []
                }
                return result
            }
            
            .filter { $0.count > 0 }
            .map { $0.map(Event.init)
        }
    }
}
