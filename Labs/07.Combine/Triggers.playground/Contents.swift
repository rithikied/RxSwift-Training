//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

example(of: "withLatestForm") {
    let bag = DisposeBag()
    let button = PublishSubject<Any?>()
    let textField = PublishSubject<String>()

    button
        .withLatestFrom(textField)
        .subscribe {
            printEvent(label: "Click: ", event: $0)
        }.disposed(by: bag)

    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")
    button.onNext(nil)
    button.onNext(nil)
}

example(of: "sample") {
    let bag = DisposeBag()
    let button = PublishSubject<Any?>()
    let textField = PublishSubject<String>()

    textField
        .sample(button)
        .subscribe(onNext: { value in
            print("Sampler Click: \(value)")
        }).disposed(by: bag)

    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")
    button.onNext(nil)
    button.onNext(nil)
    textField.onNext("Paris 2")
    textField.onNext("Paris 3")
    button.onNext(nil)
}












