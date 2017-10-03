//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "publish & connect disposal") {
    print("Create observable")
    let observable = Observable<Int>
        .interval(1, scheduler: MainScheduler.instance)
        .publish()
        .refCount()
//        .share()

    print("Subscribing")
    let subscriber = observable.subscribe(onNext: {  //#1
        print("first \($0)")
    })
    
    print("Disposing in 3 seconds")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        subscriber.dispose()
        print("subscriber Disposed.")
    }
    
    var subscriber2: Disposable?
    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        print("continue...")
        subscriber2 = observable.subscribe(onNext: {  // #2
            print("second \($0)")
        })
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
        subscriber2?.dispose()
        print("Subscriber 2 Disposed.")
    }
}









