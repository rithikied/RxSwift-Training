//
//  ViewController.swift
//  RxPin
//
//  Created by Olarn U. on 20/10/2560 BE.
//  Copyright © 2560 Olarn U. All rights reserved.
//

import UIKit
import RxSwift

let MAX_PIN_LENGTH = 6
let PIN_CHAR = "0"
let PIN_CHAR_EMPTY = ""

class ViewController: UIViewController {
    
    @IBOutlet var pins: [UITextField]!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonForgetPass: UIButton!
    @IBOutlet var buttonNumbads: [UIButton]!
    @IBOutlet weak var buttonClear: UIButton!
    
    let viewModel = ViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerButtons()
        handlePinBoxWhilePressOnNumpad()
        handleButtonClearState()
        handleWhenPinIsEnterCompleted()
    }
    
    @IBAction func touchedOnNumpads(_ sender: Any) {
        if let button = sender as? UIButton {
            viewModel.inputPin.onNext(button.tag)
        }
    }
    
    @IBAction func touchedOnButtonBack(_ sender: Any) {
        viewModel.inputPin.onNext(ViewModel.BACK_PIN)
    }
    
    @IBAction func touchdOnButtonClear(_ sender: Any) {
        viewModel.resetPassCode()
    }
}

// MARK:- Rx State Handler

extension ViewController {
    
    private func handlePinBoxWhilePressOnNumpad() {
        viewModel.passcodeLength.subscribe(onNext: { length in
            self.pins.forEach { eachPin in
                eachPin.text = eachPin.tag < length ? PIN_CHAR : PIN_CHAR_EMPTY
            }
        }).disposed(by: bag)
    }
    
    private func handleButtonClearState() {
        viewModel.pinIsEnter.subscribe(onNext: { [weak self] state in
            self?.buttonClear.isEnabled = state
            self?.buttonClear.backgroundColor = state ? UIColor.blue : UIColor.lightGray
        }).disposed(by: bag)
    }
    
    private func handleWhenPinIsEnterCompleted() {
        viewModel.onEnterPinComplete.subscribe(onNext: { pin in
            print("Done - pin = \(pin)")
        }).disposed(by: bag)
    }
}

// MARK:- UI Decoration

extension ViewController {
    
    private func roundCornerButtons() {
        buttonNumbads.forEach { eachButton in
            eachButton.layer.cornerRadius = 5
        }
        buttonClear.layer.cornerRadius = 15
    }
    
}

