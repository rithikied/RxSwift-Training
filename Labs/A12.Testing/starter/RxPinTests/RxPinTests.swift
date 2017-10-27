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
    var presenter: ViewModel!
    
    override func setUp() {
        super.setUp()
        presenter = ViewModel()
    }
    
    func testInputPinSuccess() {

    }

    func testRemovePin() {
    
    }

    func testPinIsEnter() {
    
    }

    func testPinIsNotEnter() {
    
    }

    func testOnEnterPinCompleteSuccess() {
    
    }

}




