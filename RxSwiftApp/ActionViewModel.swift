//
//  ActionViewModel.swift
//  RxSwiftApp
//
//  Created by Nawid Ayobi on 9/11/19.
//  Copyright © 2019 Nawid Ayobi. All rights reserved.
//

import Foundation
import Action
import RxSwift
import RxCocoa

class ActionViewModel {
    
    let helloAction = Action<Void,Void> { () in
        print("Hello? Is it me you're looking FOR?")
        return .just(())
    }
    
    let numberAction = Action<Int, String> { num in
        let result = "You're #" + String(num) + "!"
        return .just(result)
    }
    
    
    
}
