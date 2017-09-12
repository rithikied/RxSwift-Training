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

example(of: "merge") { 
    let bag = DisposeBag()
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    let source = Observable.of(left, right)
    source
        .merge(maxConcurrent: 1)
        .subscribe {
            printEvent(label: "merged", event: $0)
    }.disposed(by: bag)

//    Observable.merge(left, right)
//        .subscribe {
//            printEvent(label: "merge", event: $0)
//    }
//
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]

    while !leftValues.isEmpty || !rightValues.isEmpty {
        if arc4random_uniform(2) == 0 {
            if !leftValues.isEmpty {
                left.onNext(leftValues.removeFirst())
            }
        } else
            if !rightValues.isEmpty {
                right.onNext(rightValues.removeFirst())
        }
    }
}

example(of: "merge(maxConcurrent)") {
    let bag = DisposeBag()
    let o1 = Observable.of("a1", "a2", "a3", "a4", "a5")
    let o2 = Observable.of("b1", "b2", "b3", "b4", "b5")
    let o3 = Observable.of("c1", "c2", "c3", "c4", "c5")

    var i = 0
    Observable.of(o1, o2, o3)
        .merge(maxConcurrent: 2)
        .subscribe {
            i = i + 1
            printEvent(label: "\(i)", event: $0)
    }.disposed(by: bag)
}

example(of: "combineLatest") { 
    let bag = DisposeBag()
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    Observable
        .combineLatest(left, right, resultSelector: { leftItem, rightItem in
            return "\(leftItem) \(rightItem)"
        }).subscribe {
            printEvent(label: "combine: ", event: $0)
    }.disposed(by: bag)

    print("> send a value to left")
    left.onNext("Hello, ")
    print("> send a value to right")
    right.onNext("world")
    print("> send another value to right")
    right.onNext("RxSwift")
    print("> send another value to left")
    left.onNext("Have a good day.")
}

example(of: "zip") { 

    enum Weather {
        case sunny
        case cloudy
    }

    let bag = DisposeBag()
    let weathers = Observable<Weather>.of(.sunny, .cloudy, .cloudy, .sunny)
    let cities = Observable.of("Bangkok", "London", "Tokyo", "Osaka", "Hanoi")
    let icons = Observable.of("☀︎", "☁︎", "☁︎", "☀︎")

    Observable
        .zip(weathers, cities, icons) { "\($2) It's \($0) in \($1)." }
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}






