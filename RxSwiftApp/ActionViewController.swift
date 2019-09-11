//
//  ActionViewController.swift
//  RxSwiftApp
//
//  Created by Nawid Ayobi on 9/11/19.
//  Copyright © 2019 Nawid Ayobi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Action

class ActionViewController: UIViewController {

    let disposeBag = DisposeBag()
    @IBOutlet weak var hitAction: UIButton!
    var count = 0
    let vm = ActionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //hitAction.rx.action = vm.helloAction
        hitAction.rx.tap.subscribe { _ in
            self.count = self.count + 1
            self.vm.numberAction.execute(self.count)
                .subscribe(onNext: { (result) in
                    print(result)
                })
        }.disposed(by: disposeBag)

    }

}
