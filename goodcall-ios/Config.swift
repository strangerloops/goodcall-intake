//
//  Config.swift
//  goodcall-ios
//
//  Created by michaelhassin on 12/24/16.
//  Copyright © 2016 strangerware. All rights reserved.
//

import UIKit

class Config: NSObject {

    static var response = [String: String]()

    static let questions = [
      "Street Team Member Name",
      "Sign Up Location",
      "Full Name",
      "Cell Phone # (XXX-XXX-XXXX)",
      "Email",
      "Zip Code",
      "Security Question",
      "Security Answer",
      "Date of Birth (MM-DD-YYYY)",
      "Contact Name",
      "Relationship to Contact",
      "Contact Phone #"
    ]

    static let endpoint = "https://good-call-nyc-api.herokuapp.com/users/outreach_intake"

    class func questionForIndex(index: Int) -> String {
        return questions[index]
    }

    class func maxIndex() -> Int {
        return questions.count - 1
    }

    class func archiveResponse() {
        var responses = UserDefaults.standard.array(forKey: "responses")
        responses?.append(response)
        UserDefaults.standard.set(responses, forKey: "responses")
        UserDefaults.standard.synchronize()
    }

    class func clearArchive() {
        UserDefaults.standard.set([[String: String]](), forKey: "responses")
    }

    class func archivedResponses() -> [Any] {
        return UserDefaults.standard.array(forKey: "responses")!
    }

    class func archivedCount() -> Int {
        return (UserDefaults.standard.array(forKey: "responses")?.count)!
    }

    class func alert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Problem Happened", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
