//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Nawid Ayobi on 9/9/19.
//  Copyright © 2019 Nawid Ayobi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController{

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let info : BehaviorRelay<[Int]> = BehaviorRelay(value: [])
        
        info.asObservable().bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "WEEEEEE: " + String(element)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            var newInfo = info.value
            newInfo.remove(at: indexPath.row)
            info.accept(newInfo)
        }).disposed(by: disposeBag)
        
        
        
        addButton.rx.tap.subscribe(onNext: { (_) in
        var newInfo = info.value
            let toAdd = newInfo.count + 1
            newInfo.append(toAdd)
            info.accept(newInfo)
        }).disposed(by: disposeBag)


//        tableView.rx.itemDeleted
//            .subscribe {
//                print($0)
//            }
//            .disposed(by: disposeBag)
        
    }
}

//let rxTextField = textField1.rx
//rxTextField.text

/*
 
 let combined = Observable.combineLatest(textField1.rx.text.asObservable(), textField2.rx.text.asObservable()) {
 ($0,$1)}
 
 let result = combined.map { (arg) -> Int in
 return Int(arg.0!)! + Int(arg.1!)!
 }
 
 result.subscribe(onNext: { value in
 self.result.text = String(value)
 }).disposed(by: bag)
 -------------------------------------------------------------------------------------------
 
 Observable.combineLatest(textField1.rx.text.asObservable(), textField2.rx.text.asObservable()) {($0, $1)}
 .map { (arg) -> String in
 let res = Int(arg.0!)! + Int(arg.1!)!
 return String(res)
 }.bind(to: result.rx.text)
 .disposed(by: bag)
 
 */

// -- Rx Swift --
// Reactive version of swift 


// Observable: (Sequence) : Which will emit/produce signals/data/events

// Observer: which will listen/recieve those signals

// Observer subscribes to the observable

// Subscriber: Observer subscribes to observable inorder to receive data.

//type of signals
// 1. next: is the data or value emitted by Observable
// 2. completed: Observable finished emitting signals, can't emit any more events/data
// 3. error: some error while emitting signal, after this observable emits complete signal

//operator
