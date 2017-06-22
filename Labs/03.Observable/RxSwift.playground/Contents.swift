//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import RxSwift

example(of: "just") {

    let one = 1

    let observable: Observable<Int> = Observable<Int>.just(one)
    observable.subscribe { event in
        print(event)
    }
}

example(of: "Of") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of(one, two, three)
    observable.subscribe { event in
        print(event)
    }
}

example(of: "Of Array") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of([one, two, three])
    observable.subscribe { event in
        print(event)
    }
}

example(of: "From") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.from([one, two, three])
    observable.subscribe { event in
        print(event)
    }
}

