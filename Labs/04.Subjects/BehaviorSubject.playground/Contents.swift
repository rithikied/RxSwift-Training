import RxSwift

example(of: "Behavior Subject") { 
    let bag = DisposeBag()

    let subject = BehaviorSubject(value: "Initial Value")
    let subscriber1 = subject.subscribe {
        printEvent(label: "1)", event: $0)
    }
    subscriber1.disposed(by: bag)

    subject.onNext("Second Value")

    let subscriber2 = subject.subscribe {
        printEvent(label: "2)", event: $0)
    }
    subscriber2.disposed(by: bag)

    subject.onError(MyError.anError)
}
