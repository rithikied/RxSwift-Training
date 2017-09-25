//
//  UIVieViewController+Alert.swift
//  Combinestagram
//
//  Created by Olarn U. on 9/25/2560 BE.
//  Copyright © 2560 Underplot ltd. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {

    func showMessage(title: String, description: String) -> Observable<Void> {
        return Observable.create({ [weak self] observer in
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Close", style: UIAlertActionStyle.default, handler: { action in
                    observer.onCompleted()
            }))
            self?.present(alert, animated: true, completion: nil)
            return Disposables.create()
        })
    }
}
