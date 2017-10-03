//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

func callServer() {
    print("server call")
}

example(of: "same observable") {
    let bag = DisposeBag()
    let observable = Observable<Void>.just(callServer()).share()
    
    observable.subscribe( onNext: {
        print("observable 1 called")
    }).disposed(by: bag)

    observable.subscribe( onNext: {
        print("observable 2 called")
    }).disposed(by: bag)
}

