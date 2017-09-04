import RxSwift

example(of: "Publish Subject") {
    let bag = DisposeBag()

    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening?")

    let subscriberOne = subject.subscribe(onNext: { string in
        print("SubscriberOne: ", string)
    }, onCompleted: {
        print("SubscriberOne: completed")
    })
    subscriberOne.disposed(by: bag)

    subject.on(.next("1"))

    let subscriberTwo = subject.subscribe(onNext: { string in
        print("SubscriberTwo: ", string)
    }, onCompleted: {
        print("SubscriberTwo: completed")
    })
    subscriberTwo.disposed(by: bag)

    subject.on(.next("2"))

    subject.onCompleted()

    subject.on(.next("3"))

    subject.subscribe(onNext: { string in
        print("SubscriberThree: ", string)
    }, onCompleted: {
        print("SubscriberThree: completed")
    }).disposed(by: bag)
}
