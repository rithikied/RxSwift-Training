//
//  RxPinTests.swift
//  RxPinTests
//
//  Created by Olarn U. on 21/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import RxPin

class RxPinTests: XCTestCase {
    
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    var viewModel: ViewModel!
    let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }
    
    func testPasscodeIs123456WhenEnterPin1234567890() {
        let expect = expectation(description: #function)
        let expectedPasscode = "123456"
        let pinToEnter = "1234567890"
        var actualPasscode = ""
        
        viewModel.onEnterPinComplete.asObservable()
            .subscribe(onNext: { passcode in
                actualPasscode = passcode
                expect.fulfill()
            }).disposed(by: bag)
        
        pinToEnter.characters.forEach { eachPin in
            viewModel.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        
        waitForExpectations(timeout: 1) { error in
            if let e = error {
                XCTFail(e.localizedDescription)
            }
            XCTAssertEqual(expectedPasscode, actualPasscode)
        }
    }

    func testPasscodeIs123400WhenChangeLast2DigitsWith00() {
        let expect = expectation(description: #function)
        let expectedPasscode = "123400"
        let pinToEnter = "123456"
        var actualPasscode = ""
        
        viewModel.onEnterPinComplete.asObservable()
            .skip(1)
            .subscribe(onNext: { passcode in
                actualPasscode = passcode
                expect.fulfill()
            }).disposed(by: bag)
        
        pinToEnter.characters.forEach { eachPin in
            viewModel.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        
        viewModel.inputPin.onNext(ViewModel.BACK_PIN)
        viewModel.inputPin.onNext(ViewModel.BACK_PIN)
        viewModel.inputPin.onNext(0)
        viewModel.inputPin.onNext(0)
        
        waitForExpectations(timeout: 1) { error in
            if let e = error {
                XCTFail(e.localizedDescription)
            }
            XCTAssertEqual(expectedPasscode, actualPasscode)
        }
    }

    func testPinIsEnterShouldBeTrueWhenEnterSomePins() {
        let pinIsEnterObservable = viewModel.pinIsEnter.subscribeOn(scheduler)
        viewModel.inputPin.onNext(1)
        do {
            guard let pinIsEnter = try pinIsEnterObservable.toBlocking().first() else {
                return
            }
            XCTAssertEqual(pinIsEnter, true)
        } catch (let error) {
            print(error.localizedDescription)
            XCTFail(#function)
        }
    }

    func testPinIsEnterShouldBeFalseWhenRemoveAllPins() {
        let pinIsEnterObservable = viewModel.pinIsEnter.subscribeOn(scheduler)
        viewModel.inputPin.onNext(1)
        viewModel.inputPin.onNext(ViewModel.BACK_PIN)
        
        do {
            guard let pinIsEnter = try pinIsEnterObservable.toBlocking().first() else {
                return
            }
            XCTAssertEqual(pinIsEnter, false)
        } catch (let error) {
            print(error.localizedDescription)
            XCTFail(#function)
        }
    }

    func testPasscodeIs000000WhenEnterPin000000() {
        let expectedPassCode = "000000"
        let pinEnterCompletedObservable = viewModel.onEnterPinComplete.subscribeOn(scheduler)
        expectedPassCode.characters.forEach { eachPin in
            viewModel.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        let actualPasscode = try! pinEnterCompletedObservable.toBlocking().first()
        XCTAssertEqual(expectedPassCode, actualPasscode)
    }

    func testPassCodeIsEmptyWhenCallResetPasscode() {
        let passcodeLengthObservable = viewModel.passcodeLength.subscribeOn(scheduler)
        "000000".characters.forEach { eachPin in
            viewModel.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        
        viewModel.resetPassCode()
        
        let passcodeLength = try! passcodeLengthObservable.toBlocking().first()
        XCTAssertEqual(0, passcodeLength)
    }
}




