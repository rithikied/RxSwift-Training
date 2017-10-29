//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "publish, connect, disposal") {
    
    print("Create observable")
    let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .publish()
    
    let disposer = observable.connect()
    
    print("Subscribing in 3 seconds")
    
    var subscriber: Disposable!
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        subscriber = observable.subscribe(onNext: {
            print("subscriber #1 - \($0)")
        })
    }

    print("Dispose in 6 seconds")

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
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
        disposer.dispose()
        print("Disposer dispose()")
    }
}









