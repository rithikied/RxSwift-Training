//
//  ViewModel.swift
//  RxPin
//
//  Created by Olarn U. on 21/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    static let BACK_PIN = -1

    let bag = DisposeBag()

    init() {
        handleAddPinToPassCode()
        handleRemovePinFromPasscode()
    }
    
    // MARK:- input
    
    let inputPin = PublishSubject<Int>()
    
    private func handleAddPinToPassCode() {
        inputPin
            .filter { self.isPin(digit: $0) }
            .filter { _ in self.passcode.value.characters.count < MAX_PIN_LENGTH }
            .subscribe(onNext: { pin in
                self.passcode.value = self.passcode.value + "\(pin)"
            }).disposed(by: bag)
    }
    
    // MARK:- Process
    
    private func handleRemovePinFromPasscode() {
        inputPin
            .filter { $0 == -1 }
            .filter { _ in self.passcode.value.characters.count > 0 }
            .subscribe(onNext: { _ in
                self.passcode.value.characters.removeLast()
            }).disposed(by: bag)
    }

    func resetPassCode() {
        passcode.value = ""
    }
    
    private func isPin(digit: Int) -> Bool {
        return digit > -1 && digit < 10
    }
    
    // MARK:- output
    
    private let passcode = Variable<String>("")
    
    var passcodeLength: Observable<Int> {
        return passcode
            .asObservable()
            .map { code in code.characters.count }
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
            .filter { $0.characters.count == MAX_PIN_LENGTH }
    }
}





