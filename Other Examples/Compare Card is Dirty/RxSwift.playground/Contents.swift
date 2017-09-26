//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import RxSwift

struct Card: Equatable {
    var email: String = ""
    var acceptEBilling = false
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.email == rhs.email && lhs.acceptEBilling == rhs.acceptEBilling
    }
}

//example(of: "Compare 2 Cards") {
//    let card1 = Card(email: "a@mail.com", acceptEBilling: true)
//    let card2 = Card(email: "a@mail.com", acceptEBilling: true)
//    print(card1 == card2)
//}

example(of: "Observable") {
    let bag = DisposeBag()
    let originalCards = [
        Card(email: "a@mail.com", acceptEBilling: true),
        Card(email: "b@mail.com", acceptEBilling: true),
        Card(email: "c@mail.com", acceptEBilling: true),
        Card(email: "d@mail.com", acceptEBilling: false),
        Card(email: "e@mail.com", acceptEBilling: false)
    ]
    let updatedCards = [
        Card(email: "x@mail.com", acceptEBilling: true),  // เอา
        Card(email: "y@mail.com", acceptEBilling: false), // เอา
        Card(email: "c@mail.com", acceptEBilling: true),
        Card(email: "d@mail.com", acceptEBilling: true), // เอา
        Card(email: "e@mail.com", acceptEBilling: false)
    ]
    
    let originObservable = Observable.from(originalCards)
    let updatedObservable = Observable.from(updatedCards)
    var emailChangeObjs = [Card]()
    var acceptEBillingObjs = [Card]()
    
    Observable.zip(originObservable, updatedObservable)
        .filter { $0 != $1 }
        .flatMap({ (old, new) in
            return Observable.just(new)
        })
        .subscribe(onNext: {
            if $0.acceptEBilling {
                acceptEBillingObjs.append($0)
            } else {
                emailChangeObjs.append($0)
            }
        })
        .disposed(by: bag)
    
    print("\r\nemailChanged = \(emailChangeObjs.count) : \r\n\(emailChangeObjs)")
    print("\r\naccept e-billing = \(acceptEBillingObjs.count): \r\n\(acceptEBillingObjs)")
}
