//
//  SecondViewController.swift
//  RxSwiftApp
//
//  Created by Nawid Ayobi on 9/10/19.
//  Copyright © 2019 Nawid Ayobi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class SongProvider {
    let urlString = ""
    func getSongs() -> Observable<[Album]> {
        return Observable<[Album]>.create({ (obs) -> Disposable in
            let requestObservable = Observable.just(self.urlString)
                .map{URL(string: $0)!}
                .map{URLRequest(url: $0)}
            requestObservable.subscribe(onNext: { (req) in
                URLSession.shared.rx
                .data(request: req)
                    .subscribe(onNext: { (data) in
                        do {
                            let models = try JSONDecoder().decode([Album].self, from: data)
                                obs.onNext(models)
                                obs.onCompleted()
                            
                        } catch {
                            print("some error getting json")
                        }
                    })
            })
            return Disposables.create {print("sfds")}
        }
    )}
}

struct Album  : Codable {
    var title : String
    var artist : String
    var url : String
    var image : String
}


class SongProviderController: UIViewController {
let dispose = DisposeBag()
    override func viewDidLoad() {

        super.viewDidLoad()
        let myObservable = createObservable()
        myObservable.subscribe(onNext: { (data) in
            print(data)
        }).disposed(by: dispose)

    }
    
    func createObservable() -> Observable<[String]>{
        return Observable.create({ (ob) -> Disposable in
            ob.onNext(["One","Two","Three"])//emitting a next signal
            ob.onError("Oops!" as! Error)
            ob.onCompleted()
            
            return Disposables.create {
                print("I will be disposed")
            }
        })
        
    }
    
}
