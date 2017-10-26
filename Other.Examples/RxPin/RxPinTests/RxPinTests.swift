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
    var presenter: ViewPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = ViewPresenter()
    }
    
    func testInputPinSuccess() {
        // Arrange
        let expected = "123456"
        
        // Act
        "1234567890".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        
        // Assert
        XCTAssertTrue(expected == presenter.passCode.value)
    }

    func testRemovePin() {
        // Arrange
        let expected = "1234"
        "123456".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        
        // Act
        presenter.inputPin.onNext(-1)
        presenter.inputPin.onNext(-1)
        
        // Assert
        XCTAssertTrue(expected == presenter.passCode.value)
    }

    func testPinIsEnter() {
        // Arrange
        let isEnterPinObservable = presenter.pinIsEnter.subscribeOn(scheduler)
        
        // Act
        presenter.inputPin.onNext(1)
        
        // Assert
        do {
            guard let result = try isEnterPinObservable.toBlocking().first() else { return }
            XCTAssertTrue(result)
        } catch {
            print(error)
        }
    }

    func testPinIsNotEnter() {
        // Arrange
        let isEnterPinObservable = presenter.pinIsEnter.subscribeOn(scheduler)
        
        // Act
        presenter.resetPassCode()
        
        // Assert
        do {
            guard let result = try isEnterPinObservable.toBlocking().first() else { return }
            XCTAssertFalse(result)
        } catch {
            print(error)
        }
    }

    func testOnEnterPinCompleteSuccess() {
        // Arrange
        let enterPinCompleteObservable = presenter.onEnterPinComplete.subscribeOn(scheduler)
        
        // Act
        for pin in 0...5 {
            presenter.inputPin.onNext(pin)
        }
        
        // Assert
        let result = try! enterPinCompleteObservable.toBlocking().first()
        XCTAssertTrue(result == "012345")
    }

}




