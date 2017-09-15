//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

example(of: "switch") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    var leftDisposer = left.amb(right).subscribe(onNext: {
        print($0)
    })

    left.onNext("round 1: left 1")
    right.onNext("round 1: right 1")
    left.onNext("round 1: left 2")
    left.onNext("round 1: left 3")
    right.onNext("round 1: right 2")

    print("-----")

    leftDisposer.dispose()

    leftDisposer = left.amb(right).subscribe(onNext: {
        print($0)
    })

    right.onNext("round 2: right 1")
    left.onNext("round 2: left 1")
    left.onNext("round 2: left 2")
    left.onNext("round 2: left 3")
    right.onNext("round 2: right 2")

    leftDisposer.dispose()
}

example(of: "switchLatest") { 
    let bag = DisposeBag()
    let one = PublishSubject<String>()
    let two = PublishSubject<String>()
    let three = PublishSubject<String>()

    let source = PublishSubject<PublishSubject<String>>()

    source
        .switchLatest()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)

    source.onNext(one)
    one.onNext("Text from source one")
    one.onNext("  ...and another from source one")

    source.onNext(three)
    two.onNext("Text from source two")
    three.onNext("Text from source three")

    source.onNext(one)
    one.onNext("New text from source one")
}

















