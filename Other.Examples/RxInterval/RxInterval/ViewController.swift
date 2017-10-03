//
//  ViewController.swift
//  RxInterval
//
//  Created by Olarn U. on 1/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import UIKit
import RxSwift

let interval = 1
let delayBeforeObserve = 2

class ViewController: UIViewController {

    let bag = DisposeBag()
    let isRunning = Variable(false)
    @IBOutlet weak var labelStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isRunning.asObservable()
            .debug("isRunning")
            .flatMapLatest { currentIsRunning in
                currentIsRunning ?
                    Observable<Int>.interval(
                        RxTimeInterval(interval),
                        scheduler: MainScheduler.instance) :
                    .empty()
            }
            .delay(RxTimeInterval(delayBeforeObserve), scheduler: MainScheduler.instance)
            .debug("timer")
            .subscribe(onNext: { [weak self] value in
                self?.labelStatus.text = "Status: Running (\(value))"
            })
            .disposed(by: bag)
        
        isRunning.asObservable()
            .filter { $0 == false }
            .subscribe(onNext : { [weak self] _ in
                self?.labelStatus.text = "Status: Stopped"
            })
            .disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isRunning.value = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isRunning.value = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonStart(_ sender: Any) {
//        self.isRunning.value = !self.isRunning.value
    }
    
}

