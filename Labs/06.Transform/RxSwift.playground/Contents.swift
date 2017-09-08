import XCPlayground

import RxSwift

example(of: "toArray") {
    let bag = DisposeBag()
    Observable
        .of("A", "B", "C")
        .toArray()
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "map") {
    let bag = DisposeBag()
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut

    Observable<NSNumber>
        .of(123, 4, 5)
        .map ({ number -> String in
            return formatter.string(from: number) ?? ""
        })
        .subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

example(of: "mapWithIndex") { 
    let bag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6)
        .mapWithIndex { element, index in
            index > 2 ? element * 2 : element
        }.subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
}

struct Student {
    var score: BehaviorSubject<Int>
}

example(of: "flatMap") {
    let bag = DisposeBag()

    var ryan = Student(score: BehaviorSubject(value: 80))
    var ben = Student(score: BehaviorSubject(value: 90))

    let scoring = PublishSubject<Student>()
    scoring
        .flatMap({ student in
            student.score.asObservable()
        })
        .subscribe(onNext: { (value) in
            print(value)
        }, onCompleted: { 
            print("completed")
        }, onDisposed: { 
            print("disposed")
        }).disposed(by: bag)

    scoring.onNext(ryan)
    scoring.onNext(ben)

    ryan.score.onNext(30)

    ryan.score.onCompleted()
    ben.score.onNext(60)

    ben.score.onCompleted()
    ryan.score.onNext(50)

    scoring.onCompleted()
}

example(of: "flatMapLatest") { 
    let bag = DisposeBag()

    let ryan = Student(score: BehaviorSubject<Int>(value: 80))
    let ben = Student(score: BehaviorSubject<Int>(value: 90))

    let scoring = PublishSubject<Student>()
    scoring
        .flatMapLatest({
            $0.score.asObservable()
        })
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)

    scoring.onNext(ryan)
    ryan.score.onNext(85)

    scoring.onNext(ben)
    ryan.score.onNext(95)  // <- will not emit

    ben.score.onNext(100)
}







