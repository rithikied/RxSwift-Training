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

example(of: "Share Subscription") {
    let numbers = Observable<Int>.create({ observer in
        let number = getRunningNumber()
        observer.onNext(number)
        observer.onNext(number + 1)
        observer.onNext(number + 2)
        return Disposables.create()
    })
    
    let observable = numbers.share()
    
    observable.subscribe {
        print($0)
    }.disposed(by: bag)
    
    observable.subscribe {
        print($0)
    }.disposed(by: bag)
}
