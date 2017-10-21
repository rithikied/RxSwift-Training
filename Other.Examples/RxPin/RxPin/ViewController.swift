//
//  ViewController.swift
//  RxPin
//
//  Created by Olarn U. on 20/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var pins: [UITextField]!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonForgetPass: UIButton!
    @IBOutlet var buttonNumbads: [UIButton]!
    @IBOutlet weak var buttonClear: UIButton!
    
    let presenter = ViewPresenter()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerButtons()
        handlePinBoxWhilePressOnNumpad()
        handleButtonClearState()
        handleWhenPinIsEnterCompleted()
    }

    @IBAction func touchedOnNumpads(_ sender: Any) {
        if !(sender is UIButton) {
            return
        }
        presenter.inputPin.onNext((sender as! UIButton).tag)
    }
    
    @IBAction func touchedOnButtonBack(_ sender: Any) {
        presenter.inputPin.onNext(-1)
    }
    
    @IBAction func touchdOnButtonClear(_ sender: Any) {
        presenter.resetPassCode()
    }
}

// MARK:- State Handler

extension ViewController {
    
    private func roundCornerButtons() {
        buttonNumbads.forEach { eachButton in
            eachButton.layer.cornerRadius = 5
        }
        buttonClear.layer.cornerRadius = 17
    }
    
    private func handlePinBoxWhilePressOnNumpad() {
        presenter.passCode.asObservable().subscribe(onNext: { value in
            self.pins.forEach { eachPin in
                eachPin.text = eachPin.tag < value.characters.count ? "0" : ""
            }
        }).disposed(by: bag)
    }
    
    private func handleButtonClearState() {
        presenter.pinIsEnter
            .subscribe(onNext: { [weak self] state in
                self?.buttonClear.isEnabled = state
                self?.buttonClear.backgroundColor = state ? UIColor.blue : UIColor.lightGray
            })
            .disposed(by: bag)
    }
    
    private func handleWhenPinIsEnterCompleted() {
        presenter.onEnterPinComplete
            .subscribe(onNext: { pin in
                print("Done - pin = \(pin)")
            })
            .disposed(by: bag)
    }
}

