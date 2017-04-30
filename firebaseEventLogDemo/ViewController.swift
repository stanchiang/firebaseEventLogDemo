//
//  ViewController.swift
//  firebaseEventLogDemo
//
//  Created by Stanley Chiang on 4/30/17.
//  Copyright © 2017 Stanley Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var buttonA = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
    var buttonB = UIButton(frame: CGRect(x: 200, y: 300, width: 100, height: 100))
    var buttonC = UIButton(frame: CGRect(x: 200, y: 500, width: 100, height: 100))
    var buttonArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        buttonA.setTitle(Events.AAAA.rawValue, for: .normal)
        buttonB.setTitle(Events.BBBB.rawValue, for: .normal)
        buttonC.setTitle(Events.CCCC.rawValue, for: .normal)
        
        buttonArray = [buttonA, buttonB, buttonC]
        
        for button in buttonArray {
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    func buttonTapped(sender:UIButton) {
        switch sender.titleLabel!.text! {
        case Events.AAAA.rawValue:
            print(Events.AAAA.rawValue)
        case Events.BBBB.rawValue:
            print(Events.BBBB.rawValue)
        case Events.CCCC.rawValue:
            print(Events.CCCC.rawValue)
        default:
            print("unknown button tapped")
        }
    }
}

enum Events:String {
    case AAAA
    case BBBB
    case CCCC
}
