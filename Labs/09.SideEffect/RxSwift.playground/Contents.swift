//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "Side effect") {
    let bag = DisposeBag()
    var i = 0
    
    let observable = Observable
        .range(start: 1, count: 3)
        .map { current -> Int in
            i = i + 1
            return current + i
    }
    
    observable
        .subscribe(onNext: { value in
            print("observer -> \(value)")
        }).disposed(by: bag)

    observable
        .subscribe(onNext: { value in
            print("logging -> \(value)")
        }).disposed(by: bag)
}

example(of: "Avoid Side effect") {
    let bag = DisposeBag()
    
    var i = 0
    let observable = Observable.range(start: 1, count: 3)
        .map { current -> Int in
            i = i + 1
            return current + i
    }
    
    let interceptObservable = observable.do(onNext: { value in
        print("logging on Next - \(value)")
    }, onCompleted: {
        print("logging on Completed.")
    })
        
    interceptObservable.subscribe(onNext: { value in
        print("observer -> \(value)")
    }).disposed(by: bag)
}
