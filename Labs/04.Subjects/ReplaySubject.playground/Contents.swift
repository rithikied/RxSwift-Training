//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "Relay Subject") { 
    let bag = DisposeBag()
    let subject = ReplaySubject<String>.create(bufferSize: 2)

    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")

    subject.subscribe {
        printEvent(label: "1)", event: $0)
    }.disposed(by: bag)

    subject.onNext("4")

    subject.onError(MyError.anError)
    subject.disposed(by: bag)

    subject.subscribe {
        printEvent(label: "2)", event: $0)
    }.disposed(by: bag)
}
