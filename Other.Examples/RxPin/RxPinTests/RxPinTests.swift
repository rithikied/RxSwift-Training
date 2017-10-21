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
    
    func testInputPinSuccess() {
        let presenter = ViewPresenter()
        let expected = "123456"
        "1234567890".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        XCTAssertTrue(expected == presenter.passcode.value)
    }
    
    func testRemovePin() {
        let presenter = ViewPresenter()
        let expected = "1234"
        "123456".characters.forEach { eachPin in
            presenter.inputPin.onNext(Int(String(eachPin)) ?? 0)
        }
        presenter.inputPin.onNext(-1)
        presenter.inputPin.onNext(-1)
        XCTAssertTrue(expected == presenter.passcode.value)
    }
}
