//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "collection reduce") {
    let numbers = [1, 2, 3, 4, 5]

    let total = numbers.reduce(0, { result, current -> Int in
        return result + current
    })
    print(total)

    let total2 = numbers.reduce(0, +)
    print(total2)
}

example(of: "reduce") {
    let bag = DisposeBag()

    let source = Observable.of(1, 2, 3, 4, 5)
    let observable = source.reduce(100, accumulator: { (result, value) -> Int in
        return result + value
    })

    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: bag)
}

example(of: "reduce with Subject") { 
    let bag = DisposeBag()

    let source = PublishSubject<Int>()
    source
        .reduce(0, accumulator: { (result, value) -> Int in
            return result + value
        })
        .subscribe(onNext: {
            print($0)
        })
    .disposed(by: bag)

    source.onNext(1)
    source.onNext(2)
    source.onCompleted()
}

example(of: "scan") {
    let bag = DisposeBag()
    let source = Observable.of(1, 3, 5, 7, 9)

    let observable = source.scan(0, accumulator: +)
    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: bag)
}









