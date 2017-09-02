//: Playground - noun: a place where people can play

import UIKit
import RxSwift

challenge(of: "Chapter 1-1") {
    let bag = DisposeBag()
    let observable = Observable<Void>.never()

    let disposable = observable.do(onSubscribe: {
        print("do subscribe")
    }, onSubscribed: { 
        print("do subscrubed")
    }).subscribe(onDisposed: {
        print("on dispose")
    })

    disposable.disposed(by: bag)
}

challenge(of: "Chapter 1-2") {
    let bag = DisposeBag()
    let observable = Observable<Void>.never()

    let disposable = observable
        .debug()
        .subscribe(onDisposed: {
            print("on dispose")
        })

    disposable.disposed(by: bag)
}
