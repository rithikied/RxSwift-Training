//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

let bag = DisposeBag()

example(of: "Cold Observable") {
    let coldObservable = Observable<String>.create { observer -> Disposable in
        observer.onNext("Foo")
        observer.onNext("Bar")
        return Disposables.create()
    }
    
    coldObservable.subscribe {
        printEvent(label: "Cold Observable say: ", event: $0)
    }.disposed(by: bag)

    coldObservable.subscribe {
        printEvent(label: "Another cold Observable say: ", event: $0)
    }.disposed(by: bag)
}

