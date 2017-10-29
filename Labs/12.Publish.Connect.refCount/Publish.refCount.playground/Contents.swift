//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "publish refCount") {
    
    print("Create observable")
    let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .publish()
        .refCount()
    
    print("Subscribing in 3 seconds")
    
    var subscriber: Disposable!
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        subscriber = observable.subscribe(onNext: {
            print("subscriber #1 - \($0)")
        })
    })
    
    print("Disposing in 6 seconds")
    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        subscriber.dispose()
        print("subscriber Disposed.")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
        print("continue...")
        observable.subscribe(onNext: {
            print("subscriber #2 - \($0)")
        })
    }
}









