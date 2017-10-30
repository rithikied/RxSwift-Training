import RxSwift

example(of: "Async Subject") {
    let bag = DisposeBag()
    
    let subject = AsyncSubject<String>()
    
    subject.onNext("1")
    
    subject.subscribe {
        print($0)
    }.disposed(by: bag)
    
    subject.onNext("2")
    subject.onNext("3")

    subject.onCompleted()
    
    subject.subscribe {
        print($0)
    }.disposed(by: bag)
    
    subject.onNext("4")
    subject.onCompleted()
}
