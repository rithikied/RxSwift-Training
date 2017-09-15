//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

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











