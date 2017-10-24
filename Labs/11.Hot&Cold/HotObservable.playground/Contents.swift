//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

let bag = DisposeBag()

class MyTrigger {
    typealias Trigger = (String) -> ()
    var trigger = [Trigger]()

    func call(message: String) {
        self.trigger.forEach { eachTrigger in
            eachTrigger(message)
        }
    }
}

example(of: "Hot Observable with Callback") {
    
    let triggerObj = MyTrigger()
    let hotObservable = Observable<String>.create { observer -> Disposable in
        triggerObj.trigger.append({ message in
            observer.onNext(message)
        })
        return Disposables.create()
    }

    hotObservable.subscribe(onNext: { value in
        print("Hot observable 1 say: \(value)")
    }).disposed(by: bag)
    
    triggerObj.call(message: "Foo")
    
    hotObservable.subscribe(onNext: { value in
        print("Hot observable 2 say: \(value)")
    }).disposed(by: bag)

    triggerObj.call(message: "Bar")
}

example(of: "Hot Observable with Subject") {

    let subject = PublishSubject<String>()
    
    let hotObservable = Observable<String>.create { observer -> Disposable in
        subject.subscribe(onNext: { value in
            observer.onNext(value)
        }).disposed(by: bag)
        return Disposables.create()
    }
    
    hotObservable.subscribe({ element in
        printEvent(label: "Hot Observable 1 say: ", event: element)
    }).disposed(by: bag)
    
    subject.onNext("Foo")
    
    hotObservable.subscribe({ element in
        printEvent(label: "Hot Observable 2 say: ", event: element)
    }).disposed(by: bag)
    
    subject.onNext("Bar")
}
