//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "publish & connect") {
    print("Create observable")
    let observable = Observable.just(1).publish()
    
    print("Subscribing")
    observable.subscribe(onNext: {
        print("first \($0)")
    })
    
    observable.subscribe(onNext: {
        print("second \($0)")
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        print("Calling connect after 3 seconds")
        observable.connect()
    }
}









