//
//  ViewPresenter.swift
//  RxPin
//
//  Created by Olarn U. on 21/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import Foundation
import RxSwift

class ViewPresenter {
    
    let bag = DisposeBag()
    
    // MARK:- input
    let inputPin = PublishSubject<Int>()

    // MARK:- output
    private let passcode = Variable<String>("")
    var passCode: Variable<String> {
        return self.passcode
    }
    
    var pinIsEnter: Observable<Bool> {
        return passcode
            .asObservable()
            .map { code in code.characters.count > 0 }
            .distinctUntilChanged()
    }
    
    var onEnterPinComplete: Observable<String> {
        return passcode
            .asObservable()
            .filter { $0.characters.count == 6 }
    }
    
    init() {
        handleAddPinToPassCode()
        handleRemovePinFromPasscode()
    }
    
    func resetPassCode() {
        passcode.value = ""
    }

    private func handleAddPinToPassCode() {
        inputPin
            .filter { $0 > -1 && $0 < 10 }
            .filter { _ in self.passcode.value.characters.count < 6 }
            .subscribe(onNext: { pin in
                self.passcode.value = self.passcode.value + "\(pin)"
            }).disposed(by: bag)
    }
    
    private func handleRemovePinFromPasscode() {
        inputPin
            .filter { $0 == -1 }
            .filter { _ in self.passcode.value.characters.count > 0 }
            .subscribe(onNext: { _ in
                self.passcode.value.characters.removeLast()
            }).disposed(by: bag)
    }
}





