//: Please build the scheme 'RxSwiftPlayground' first

import XCPlayground
import RxSwift

let bag = DisposeBag()
var runningNumber = 0
func getRunningNumber() -> Int {
    runningNumber = runningNumber + 1
    print("Get \(runningNumber)")
    return runningNumber
}

example(of: "Share Subscription 2") {
    let observable = Observable
        .of(getRunningNumber(), getRunningNumber(), getRunningNumber())
        .share()
    
    observable
        .filter { $0 % 2 == 0 }
        .subscribe {
        print($0)
    }.disposed(by: bag)

    observable
        .filter { $0 > 1 }
        .subscribe {
        print($0)
    }.disposed(by: bag)
}

example(of: "Share with Subject") {
    let number = PublishSubject<Int>()
    
    let observable = number.asObserver().share()
    
    observable.subscribe {
        print("#1 \($0)")
    }.disposed(by: bag)
    
    observable
        .ignoreElements()
        .subscribe {
            print("#2 \($0)")
    }.disposed(by: bag)

    number.onNext(getRunningNumber())
    number.onNext(getRunningNumber())
    number.onCompleted()
}
