//: Playground - noun: a place where people can play

import UIKit
import RxSwift

challenge(of: "Combine") {
    let bag = DisposeBag()
    let index = Observable.of(1, 2, 3, 4, 5)
    let value = Observable.of(1, 3, 2, 5).scan(0, accumulator: +)

    Observable
        .zip(index, value)
        .subscribe(onNext: {
            print("Index: \($0.0) value: \($0.1)")
        })
        .disposed(by: bag)
}
