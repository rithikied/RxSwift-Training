//
//  ViewModel.swift
//  TryRxAlamofire
//
//  Created by Olarn U. on 6/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class ViewModel {
    
    private let bag = DisposeBag()
    let textBaseCurrency = Variable<String>("")
    let textToCurrency = Variable<String>("")
    let textRate = Variable<String>("Rate:")
    
    init() {
        let baseObservable = textBaseCurrency.asObservable().filter { $0 != "" }
        let toObservable = textToCurrency.asObservable().filter { $0 != "" }
        Observable.combineLatest(baseObservable, toObservable)
            .map { "http://api.fixer.io/latest?base=\($0)&symbols=\($1)" }
            .flatMapLatest { RestAPI().request(url: $0) }
            .subscribe(onNext: { [weak self] result in
                if result.0 == .success {
                    if let baseCurrency = self?.textToCurrency.value {
                        self?.textRate.value = "Rate: \(JSON(result.1)["rates"][baseCurrency])"
                    }
                } else {
                    self?.textRate.value = "Error: \(JSON(result.1)["error"])"
                }
            }, onError: { [weak self] _ in
                self?.textRate.value = "Rate: Unknow"
            })
            .disposed(by: bag)
    }
}
