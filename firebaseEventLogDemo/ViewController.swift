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
    var buttonB = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    var buttonC = UIButton(frame: CGRect(x: 200, y: 300, width: 100, height: 100))
    var undoButton = UIButton(frame: CGRect(x: 200, y: 500, width: 100, height: 100))
    var redoButton = UIButton(frame: CGRect(x: 200, y: 600, width: 100, height: 100))
    var buttonArray = [UIButton]()
    var eventHistory = [Events]()
    var undoList = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        buttonA.setTitle(Events.AAAA.rawValue, for: .normal)
        buttonB.setTitle(Events.BBBB.rawValue, for: .normal)
        buttonC.setTitle(Events.CCCC.rawValue, for: .normal)
        undoButton.setTitle(Actions.undo.rawValue, for: .normal)
        redoButton.setTitle(Actions.redo.rawValue, for: .normal)
        
        buttonArray = [buttonA, buttonB, buttonC, undoButton, redoButton]
        
        for button in buttonArray {
            button.setTitleColor(UIColor.black, for: .normal)
            if button.titleLabel!.text == Actions.redo.rawValue || button.titleLabel!.text! == Actions.undo.rawValue {
                button.addTarget(self, action: #selector(actionTapped(sender:)), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(eventTapped(sender:)), for: .touchUpInside)
            }
            self.view.addSubview(button)
        }
    }
    
    func eventTapped(sender:UIButton) {
        var event:Events?
        
        switch sender.titleLabel!.text! {
        case Events.AAAA.rawValue:
            event = Events.AAAA
        case Events.BBBB.rawValue:
            event = Events.BBBB
        case Events.CCCC.rawValue:
            event = Events.CCCC
        default:
            print("unknown event tapped")
        }
        
        if let ev = event {
            eventHistory.append(ev)
            undoList.removeAll()
            print(eventHistory)
        }
    }
    
    func actionTapped(sender:UIButton) {
        var action:Actions?
        
        switch sender.titleLabel!.text! {
        case Actions.undo.rawValue:
            action = Actions.undo
        case Actions.redo.rawValue:
            action = Actions.redo
        default:
            print("unknown action tapped")
        }
        
        if let ac = action {
            print("==\(ac.rawValue) START==")
            
            actionManager(action: ac)
            print(eventHistory)
            
            print("==\(ac.rawValue) END==")
        }
    }
    
    func actionManager(action:Actions) {
        switch action {
        case Actions.undo:
            undo()
        case Actions.redo:
            redo()
        }
    }
    
    func undo() {
        guard eventHistory.count > 0 else {
            print("no events to undo")
            return
        }
        undoList.append(eventHistory.removeLast())
    }
    
    func redo() {
        guard undoList.count > 0 else {
            print("no events to redo")
            return
        }
        eventHistory.append(undoList.removeLast())
    }
}

enum Events:String {
    case AAAA
    case BBBB
    case CCCC
}

enum Actions:String {
    case undo
    case redo
}
