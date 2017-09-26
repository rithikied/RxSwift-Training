//
//  PHPhotoLibrary+rx.swift
//  Combinestagram
//
//  Created by Olarn U. on 9/26/2560 BE.
//  Copyright © 2560 Underplot ltd. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
    
    static var authorized: Observable<Bool> {
        return Observable.create({ observer -> Disposable in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    requestAuthorization({ newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    })
                }
            }
            return Disposables.create()
        })
    }
}
