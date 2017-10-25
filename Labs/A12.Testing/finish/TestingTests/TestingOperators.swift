/*
 * Copyright (c) 2014-2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import XCTest
import RxSwift
import RxTest
import RxBlocking

class TestingOperators : XCTestCase {
    
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
    
    func testFilter() {
        let observer = scheduler.createObserver(Int.self)
        let observable = scheduler.createHotObservable([
            next(100, 1),
            next(200, 2),
            next(300, 3),
            next(400, 4),
            next(500, 5)
            ])
        let filteredObservable = observable.filter { $0 <= 3 }
        scheduler.scheduleAt(0) {
            self.subscription = filteredObservable.subscribe(observer)
        }
        scheduler.start()
        let results = observer.events.map {
            $0.value.element!
        }
        XCTAssertEqual(results, [1, 2, 3])
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
}



