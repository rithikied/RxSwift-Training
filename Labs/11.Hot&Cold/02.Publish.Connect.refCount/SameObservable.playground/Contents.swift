//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift
import RxCocoa

PlaygroundPage.current.needsIndefiniteExecution = true

example(of: "Not share") {
    let bag = DisposeBag()
    let url = URL(string: "https://www.google.com")!
    let requestObservable = URLSession.shared
        .rx
        .data(request: URLRequest(url: url))
    
    requestObservable.subscribe {
        print($0)
        }.disposed(by: bag)
    
    requestObservable.subscribe {
        print($0)
        }.disposed(by: bag)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
    example(of: "share") {
        let bag = DisposeBag()
        let url = URL(string: "https://www.google.com")!
        let requestObservable = URLSession.shared
            .rx
            .data(request: URLRequest(url: url))
            .share()
        
        requestObservable.subscribe {
            print($0)
            }.disposed(by: bag)
        
        requestObservable.subscribe {
            print($0)
            }.disposed(by: bag)
    }
})


