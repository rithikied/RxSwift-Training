//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

enum NumberError: Swift.Error {
    case oddNumber
}

var number = 1
func getNumber() -> Observable<Int> {
    return Observable<Int>.create({ observer -> Disposable in
        number = number + 1
        if number % 2 == 0 {
            observer.onNext(number)
        } else {
            observer.onError(NumberError.oddNumber)
        }
        return Disposables.create()
    })
}

example(of: "Hello, World") {
    let bag = DisposeBag()

    for _ in 0...9 {
        getNumber()
            .catchErrorJustReturn(0)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
    }
}

