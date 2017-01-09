//
//  HomeViewController.swift
//  goodcall-ios
//
//  Created by michaelhassin on 12/24/16.
//  Copyright © 2016 strangerware. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var count: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "📞 good call 👊"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let labelFrame = CGRect(x: 20, y: 80, width: view.frame.width, height: 130)
        let label = UILabel(frame: labelFrame)
        label.text = "this is the good call intake shebang"
        label.textColor = UIColor.black
        view.addSubview(label)
        
        let buttonFrame = CGRect(x: 20, y: 120, width: 300, height: 100)
        let startButton = UIButton(frame: buttonFrame)
        startButton.contentHorizontalAlignment = .left
        startButton.setTitle("get the ball rolling", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
        startButton.addTarget(self, action: #selector(HomeViewController.start), for: .touchUpInside)
        view.addSubview(startButton)
        
        let countFrame = CGRect(x: 20, y: 200, width: view.frame.width, height: 130)
        count = UILabel(frame: countFrame)
        count.numberOfLines = 0
        count.text = "\(Config.archivedCount()) saved responses"
        count.textColor = UIColor.black
        view.addSubview(count)
        
        let sendButtonFrame = CGRect(x: 20, y: 240, width: 300, height: 100)
        let sendButton = UIButton(frame: sendButtonFrame)
        sendButton.setTitle("SEND EM UP", for: .normal)
        sendButton.contentHorizontalAlignment = .left
        sendButton.setTitleColor(UIColor.blue, for: .normal)
        sendButton.addTarget(self, action: #selector(HomeViewController.sendClicked), for: .touchUpInside)
        view.addSubview(sendButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        count.text = "\(Config.archivedCount()) local responses"
    }

    func start(){
        let intake = IntakeViewController(index: 0)
        navigationController?.pushViewController(intake, animated: true)
    }
    
    func sendClicked() {
        send()
    }
    
    func send(){
        let url = Config.endpoint
        let responses = Config.archivedResponses() as! [[String: String]]
        for response in responses {
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            var bodyData = ""
            
            for (key, value) in response {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                bodyData += "\(escapedKey)=\(escapedValue)&"
            }
            
            request.httpBody = bodyData.data(using: String.Encoding.utf8, allowLossyConversion: true)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if (error != nil) {
                    Config.alert(message: (error?.localizedDescription)!, viewController: self)
                } else if (response as? HTTPURLResponse)?.statusCode != 204 {
                    Config.alert(message: "\((response as? HTTPURLResponse)?.statusCode)", viewController: self)
                } else {
                    Config.clearArchive()
                    self.viewWillAppear(true)
                }
            })
            task.resume()
        }
    }
}
