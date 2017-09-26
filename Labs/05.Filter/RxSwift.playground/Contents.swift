//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import RxSwift

let bag = DisposeBag()

example(of: "ignore Elements") {
    let strike = PublishSubject<String>()

    strike.subscribe(onNext: { (hit) in
        print(hit)
    }).disposed(by: bag)

    strike
        .ignoreElements()
        .subscribe(onCompleted: {
            print("You're out!!!")
        }).disposed(by: bag)

    strike.onNext("Strike 1")
    strike.onNext("Strike 2")
    strike.onNext("Strike 3")
    strike.onCompleted()
}

example(of: "elementAt") { 
    let strike = PublishSubject<String>()

    strike
        .elementAt(2)
        .subscribe(onNext: { hit in
            print(hit)
            print("You're out!!!")
        }).disposed(by: bag)

    strike.onNext("Strike 1")
    strike.onNext("Strike 2")
    strike.onNext("Strike 3")
}

example(of: "filter") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .filter { $0 % 2 == 0 }
        .subscribe(onNext: { number in
            print(number)
        }).disposed(by: bag)
}

example(of: "skip") { 
    Observable.of("A", "B", "C", "D", "E", "F")
        .skip(3)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "skipWhile") { 
    Observable
        .of(2, 2, 2, 3, 4, 5, 6)
        .skipWhile { $0 % 2 == 0 }
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "skipUntil") { 
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()

    subject
        .skipUntil(trigger)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)

    subject.onNext("1")
    subject.onNext("2")

    trigger.onNext("Go")

    subject.onNext("3")
    subject.onNext("4")
}

example(of: "take") { 
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3)
        .subscribe( onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "takeWhile") { 
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeWhile { $0 < 4 }
        .subscribe {
            print($0)
        }
        .disposed(by: bag)
}

example(of: "takeWhileWithIndex") { 
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeWhileWithIndex({ (element, index) -> Bool in
            return element < 3 && index < 5
        })
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "takeUntil") { 
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<Any?>()

    subject
        .takeUntil(trigger)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)

    subject.onNext("1")
    subject.onNext("2")

    trigger.onNext(nil)

    subject.onNext("3")
}

example(of: "distinctUntilChange") {
    Observable.of(1, 1, 2, 2, 3, 3, 2, 1)
        .distinctUntilChanged()
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "distinctUntilChange - compare") { 
    let bag = DisposeBag()
    Observable
        .of(1, 110, 2, 25, 300, 21, 310, 35, 50)
        .distinctUntilChanged({ (value1, value2) -> Bool in
            let stringValue1 = String(value1)
            let stringValue2 = String(value2)
            for char1 in stringValue1.characters {
                for char2 in stringValue2.characters {
                    if char1 == char2 {
                        return true
                    }
                }
            }
            return false
        }).subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}











