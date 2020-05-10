//
//  ViewController.swift
//  Swift06
//
//  Created by 王铁刚 on R 2/04/24.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prices = [100, 250, 560, 980]
        let taxRate = 1.08

        Observable
            .from(prices)
            .map({ price in
                Int(Double(price) * taxRate)
            })
            .subscribe({ event in
                print(event)
            })
            .dispose()
        
        test()
    }

    func test() {
        let disposeBag = DisposeBag()
        
        // Subject作成
        let subject = PublishSubject<String>()
        subject.onNext("🍎")
        
        // Observer1購読
        subject
            .subscribe(onNext: { element in
                print("Observer: 1 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 1 - Event: completed")
            }, onDisposed: {
                print("Observer: 1 - Event: disposed b")
            })
            .disposed(by: disposeBag)
        
        subject.onNext("🍣")
        
        // Observer2購読
        subject
            .map({ element in
                "\(element) is nice!"
            })
            .subscribe(onNext: { element in
                print("Observer: 2 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 2 - Event: completed")
            }, onDisposed: {
                print("Observer: 2 - Event: disposed")
            })
            .disposed(by: disposeBag)

        subject.onNext("🍔")
        
        // Observer3購読
        subject
            .subscribe(onNext: { element in
                print("Observer: 3 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 3 - Event: completed")
            }, onDisposed: {
                print("Observer: 3 - Event: disposed")
            })
            .disposed(by: disposeBag)
        
        subject.onNext("🍜")
        
        subject.onCompleted()
    }
}

