//
//  IntakeViewController.swift
//  goodcall-ios
//
//  Created by michaelhassin on 12/24/16.
//  Copyright © 2016 strangerware. All rights reserved.
//

import UIKit

class IntakeViewController: UIViewController {
    
    var index: Int
    var textField: UITextField!
    
    init(index: Int){
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = UIColor.white
        let labelFrame = CGRect(x: 50, y: 80, width: view.frame.width, height: 100)
        let label = UILabel(frame: labelFrame)
        label.text = Config.questionForIndex(index: index)
        label.textColor = UIColor.black
        
        let textFieldFrame = CGRect(x: 50, y: 150, width: view.frame.width, height: 40)
        textField = UITextField(frame: textFieldFrame)
        
        let buttonFrame = CGRect(x: 50, y: 230, width: 100, height: 100)
        
        if index == Config.maxIndex() {
            let doneButton = UIButton(frame: buttonFrame)
            doneButton.setTitle("done", for: .normal)
            doneButton.setTitleColor(UIColor.blue, for: .normal)
            doneButton.addTarget(self, action: #selector(IntakeViewController.done), for: .touchUpInside)
            view.addSubview(doneButton)
        } else {
            let nextButton = UIButton(frame: buttonFrame)
            nextButton.setTitle("next >", for: .normal)
            nextButton.setTitleColor(UIColor.blue, for: .normal)
            nextButton.addTarget(self, action: #selector(IntakeViewController.nextScreen), for: .touchUpInside)
            view.addSubview(nextButton)
        }
        
        textField.becomeFirstResponder()
        
        view.addSubview(label)
        view.addSubview(textField)
        
    }
    
    func recordResponse() {
        Config.response[Config.questionForIndex(index: index)] = textField.text
    }
    
    func nextScreen() {
        let next = IntakeViewController(index: (index + 1))
        recordResponse()
        navigationController?.pushViewController(next, animated: true)
    }
    
    func done() {
        recordResponse()
        print(Config.response)
        reset()
        print(Config.response)
    }
    
    func reset() {
        // archive response
        Config.archiveResponse()
        // clear response
        Config.response = [String:String]()
        // bounce to home page
        navigationController?.popToRootViewController(animated: true)
    }
    
    // bullshit
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
