//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

example(of: "just") {

    let one = 1

    let observable: Observable<Int> = Observable<Int>.just(one)
    observable.subscribe { event in
        print(event)
    }
}

example(of: "Of") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of(one, two, three)
    observable.subscribe { event in
        print(event)
    }
}

example(of: "Of Array") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of([one, two, three])
    observable.subscribe { event in
        print(event)
    }
}

example(of: "From, Element") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.from([one, two, three])
    observable.subscribe { event in
        if let element = event.element {
            print(element)
        }
    }
}

example(of: "onNext") {

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.from([one, two, three])
    _ = observable.subscribe(onNext: { element in
        print("element of event = \(element)")
    }, onError: { error in
        print(error.localizedDescription)
    }, onCompleted: { 
        print("... on Completed")
    }, onDisposed: { 
        print("... on Disposed")
    })
}


example(of: "Just, one more thing...") {
    var number = 1
    func getNumber() -> Int {
        number = number + 1
        print("... number is increased to \(number)")
        return number
    }
    
    Observable.of(getNumber(), getNumber(), getNumber())
}

example(of: "Empty") { 
    let observable = Observable<Void>.empty()
    observable.subscribe(onNext: {
        print("onNext")
    }, onError: { error in
        print(error.localizedDescription)
    }, onCompleted: { 
        print("onCompleted")
    }, onDisposed: { 
        print("onDisposed")
    })
}

example(of: "never") { 
    let observable = Observable<Any>.never()
    observable.subscribe(onNext: { _ in
        print("onNext")
    }, onError: { error in
        print(error.localizedDescription)
    }, onCompleted: {
        print("onCompleted")
    }, onDisposed: {
        print("onDisposed")
    })
}

example(of: "range") { 
    let observable = Observable<Int>.range(start: 1, count: 10)
    observable.subscribe(onNext: { value in
        let n = Double(value)
        let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
            2.23606).rounded())
        print(fibonacci)
    })
}

example(of: "dispose") {
    let bag = DisposeBag()
    let observable = Observable.of("A", "B", "C")
    let subscription = observable.subscribe { event in
        print(event)
    }
    subscription.dispose()
}

example(of: "disposeBag") { 
    let bag = DisposeBag()
    let observable = Observable.of(1,2,3)
    observable.subscribe({ event in
        print(event)
    }).disposed(by: bag)
}

example(of: "create") {

    enum MyError: Error {
        case anError
    }

    let bag = DisposeBag()
    let observable = Observable<String>.create({ observer -> Disposable in
        observer.onNext("first")
        observer.onCompleted()
        observer.onError(MyError.anError)
        observer.onNext("second")
        return Disposables.create()
    })

    observable.subscribe({ event in
        print(event)
    }).disposed(by: bag)
}

example(of: "deferred") { 
    let bag = DisposeBag()
    var flip = false

    let factory: Observable<Int> = Observable<Int>.deferred {
        flip = !flip
        if flip {
            return Observable.of(1,2,3)
        }
        return Observable.of(4,5,6)
    }

    for _ in 0...3 {
        factory.subscribe(onNext: { value in
            print(value, terminator: ",")
        }).disposed(by: bag)
        print()
    }
}






