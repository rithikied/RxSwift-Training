//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "Share") {
    
    print("Create observable")
    let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
         .share()
    
    print("Subscribing in 3 seconds")
    
    var subscriber: Disposable!
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        subscriber = observable.subscribe(onNext: {
            print("subscriber #1 - \($0)")
        })
    })
    
    print("Disposing in 9 seconds")
    DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
        subscriber.dispose()
        print("subscriber Disposed.")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        print("continue...")
        observable.subscribe(onNext: {
            print("subscriber #2 - \($0)")
        })
    }
}









