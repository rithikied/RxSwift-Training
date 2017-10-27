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

    }

    func testPasscodeIs123400WhenChangeLast2DigitsWith00() {

    }

    func testPinIsEnterShouldBeTrueWhenEnterSomePins() {

    }

    func testPinIsEnterShouldBeFalseWhenRemoveAllPins() {

    }

    func testPasscodeIs000000WhenEnterPin000000() {

    }

}




