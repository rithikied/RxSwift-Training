//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

example(of: "merge") {
    let bag = DisposeBag()
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    let source = Observable.of(left, right)
    source
        .merge(maxConcurrent: 1)
        .subscribe {
            printEvent(label: "merged", event: $0)
        }.disposed(by: bag)

    //    Observable.merge(left, right)
    //        .subscribe {
    //            printEvent(label: "merge", event: $0)
    //    }
    //
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]

    while !leftValues.isEmpty || !rightValues.isEmpty {
        if arc4random_uniform(2) == 0 {
            if !leftValues.isEmpty {
                left.onNext(leftValues.removeFirst())
            }
        } else
            if !rightValues.isEmpty {
                right.onNext(rightValues.removeFirst())
        }
    }
}

example(of: "merge(maxConcurrent)") {
    let bag = DisposeBag()
    let o1 = Observable.of("a1", "a2", "a3", "a4", "a5")
    let o2 = Observable.of("b1", "b2", "b3", "b4", "b5")
    let o3 = Observable.of("c1", "c2", "c3", "c4", "c5")

    var i = 0
    Observable.of(o1, o2, o3)
        .merge(maxConcurrent: 2)
        .subscribe {
            i = i + 1
            printEvent(label: "\(i)", event: $0)
        }.disposed(by: bag)
}







