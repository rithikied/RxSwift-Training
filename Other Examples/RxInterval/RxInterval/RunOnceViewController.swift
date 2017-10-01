//
//  RunOnceViewController.swift
//  RxInterval
//
//  Created by Olarn U. on 1/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import UIKit
import RxSwift

class RunOnceViewController: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Observable.just(true)
            .delay(RxTimeInterval(delayBeforeObserve), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.labelStatus.text = "Fire !!!"
            })
            .disposed(by: bag)
    }
}
