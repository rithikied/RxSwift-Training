//
//  ViewController.swift
//  TryRxAlamofire
//
//  Created by Olarn U. on 6/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var textBaseCurrency: UITextField!
    @IBOutlet weak var textToCurrency: UITextField!
    @IBOutlet weak var labelRate: UILabel!
    
    let viewModel = ViewModel()
    var bag = DisposeBag()

    // let sourceStringURL = "http://api.fixer.io/latest?base=EUR&symbols=THB"

    override func viewDidLoad() {
        super.viewDidLoad()
         handleRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        bag = DisposeBag()
        handleRx()
    }
}

extension ViewController {
    
    private func handleRx() {
        
        textBaseCurrency.rx
            .controlEvent(UIControlEvents.editingDidEnd)
            .asObservable()
            .map { self.textBaseCurrency.text ?? "" }
            .bind(to: viewModel.textBaseCurrency)
            .disposed(by: bag)
        
        textToCurrency.rx
            .controlEvent(UIControlEvents.editingDidEnd)
            .asObservable()
            .map { self.textToCurrency.text ?? "" }
            .bind(to: viewModel.textToCurrency)
            .disposed(by: bag)
        
        viewModel.textRate.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.labelRate.text = result
            }).disposed(by: bag)
    }
}

