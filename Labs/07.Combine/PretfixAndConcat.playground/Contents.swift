//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

example(of: "startWith") {
    let bag = DisposeBag()

    let numbers = Observable.of(2, 3, 4)
    let observable = numbers.startWith(1)

    observable.subscribe {
        printEvent(label: "Start with: ", event: $0)
        }.disposed(by: bag)
}

example(of: "concat") {
    let bag = DisposeBag()
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    let observable = Observable.concat([first, second])
    observable.subscribe {
        printEvent(label: "Concat result", event: $0)
        }.disposed(by: bag)

    first
        .concat(second)
        .subscribe {
            printEvent(label: "1 con 2: ", event: $0)
        }.disposed(by: bag)

    Observable
        .just(1)
        .concat(second)
        .subscribe {
            printEvent(label: "Just: ", event: $0)
        }.disposed(by: bag)
}







