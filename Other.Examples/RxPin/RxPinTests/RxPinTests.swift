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
    
    func testInputPinSuccess() {
        let presenter = ViewPresenter()
        let expected = "123456"
        "1234567890".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        XCTAssertTrue(expected == presenter.passCode.value)
    }
    
    func testRemovePin() {
        let presenter = ViewPresenter()
        let expected = "1234"
        "123456".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        presenter.inputPin.onNext(-1)
        presenter.inputPin.onNext(-1)
        XCTAssertTrue(expected == presenter.passCode.value)
    }
    
    func testPinIsEnter() {
        let presenter = ViewPresenter()
        let isEnterPinObservable = presenter.pinIsEnter.subscribeOn(scheduler)
        presenter.inputPin.onNext(1)
        do {
            guard let result = try isEnterPinObservable.toBlocking().first() else {
                return
            }
            XCTAssertTrue(result)
        } catch {
            print(error)
        }
    }

    func testPinIsNotEnter() {
        let presenter = ViewPresenter()
        let isEnterPinObservable = presenter.pinIsEnter.subscribeOn(scheduler)
        presenter.resetPassCode()
        do {
            guard let result = try isEnterPinObservable.toBlocking().first() else {
                return
            }
            XCTAssertFalse(result)
        } catch {
            print(error)
        }
    }
    
    func testOnEnterPinCompleteSuccess() {
        let presenter = ViewPresenter()
        let enterPinCompleteObservable = presenter.onEnterPinComplete.subscribeOn(scheduler)
        for pin in 0...5 {
            presenter.inputPin.onNext(pin)
        }
        do {
            guard let result = try enterPinCompleteObservable.toBlocking().first() else {
                return
            }
            XCTAssertTrue(result == "012345")
        } catch {
            print(error)
        }
    }

}




