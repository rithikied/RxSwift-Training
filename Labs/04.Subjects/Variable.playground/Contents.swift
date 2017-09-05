import UIKit
import RxSwift

example(of: "Variable") { 
    let bag = DisposeBag()

    let variable = Variable("1")
    variable.value = "2"

    variable
        .asObservable()
        .subscribe {
            printEvent(label: "1)", event: $0)
        }.disposed(by: bag)

    variable.value = "3"
}
