//
//  RxOperationTests.swift
//  RxPinTests
//
//  Created by Olarn U. on 27/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

class RxOperatorTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        super.tearDown()
    }
    
    func testAmp() {
        let observer = scheduler.createObserver(String.self)
        
        let observableA = scheduler.createHotObservable([
            next(100, "a)"),
            next(200, "b)"),
            next(300, "c)"),
            ])
        let observableB = scheduler.createHotObservable([
            next(90, "1)"),
            next(200, "2)"),
            next(300, "3)"),
            ])
        
        let ambObservable = observableA.amb(observableB)
        
        scheduler.scheduleAt(0) {
            self.subscription = ambObservable.subscribe(observer)
        }
        scheduler.start()
        
        let results = observer.events.map {
            $0.value.element!
        }
        XCTAssertEqual(results, ["1)", "2)", "3)"])
    }
    
    func testHotObservable() {
        let observer = scheduler.createObserver(Int.self)
        let observable = scheduler.createHotObservable([
            next(100, 1),
            next(200, 2),
            next(300, 3),
            next(400, 4),
            next(500, 5)
            ])
        let filteredObservable = observable.filter { $0 <= 3 }
        scheduler.scheduleAt(250) {
            self.subscription = filteredObservable.subscribe(observer)
        }
        scheduler.start()
        let results = observer.events.map {
            $0.value.element!
        }
        XCTAssertEqual(results, [3])
    }
    
    func testZip() {
        typealias zipType = (String, String)
        let observer = scheduler.createObserver(zipType.self)
        let left = scheduler.createHotObservable([
            next(100, "first"),
            next(200, "second"),
            next(300, "third")
            ])
        let right = scheduler.createHotObservable([
            next(50, "1"),
            next(150, "2")
            ])
        let zipObservable = Observable.zip(left, right)
        scheduler.scheduleAt(0) {
            self.subscription = zipObservable.subscribe(observer)
        }
        scheduler.start()
        let results = observer.events.map {
            "\($0.value.element!.0) \($0.value.element!.1)"
        }
        XCTAssertEqual(results, ["first 1", "second 2"])
    }
    
    func testColdObservable() {
        let observer = scheduler.createObserver(Int.self)
        let coldObservable = scheduler.createColdObservable([
            next(100, "first"),
            next(200, "second")
            ])
        
        var i = 0
        let mapObservable = coldObservable.map { _ -> Int in
            i = i + 1
            return i
        }
        
        scheduler.scheduleAt(300) {
            self.subscription = mapObservable.subscribe(observer)
        }
        scheduler.start()
        
        let result = observer.events.map { $0.value.element! }
        XCTAssertEqual(result, [1, 2])
    }
    
}
