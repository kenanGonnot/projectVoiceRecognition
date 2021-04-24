//
//  ViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 29/03/2021.
//

import UIKit
import VoiceIt2_IosSDK

class ViewController: UIViewController {
    var myVoiceIt:VoiceItAPITwo?
    
    
    let API_KEY = "key_c5f8c444d0504af49de136f3ce12b62a";
    let API_TOK = "tok_4fd9e0c54a584c7598cd047f74846760";
//    let language = "en-US";
    let language = "no-STT";
    let phrase = "hello i am very happy today";
    let userId = "usr_9f4b211a85b24b0886ffdc82b8f54bf9";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* Reference to ViewController , API Credentials and styles dictionary*/
        let styles = NSMutableDictionary(dictionary: ["kThemeColor":"#FBC132","kIconStyle":"default"])
        self.myVoiceIt = VoiceItAPITwo(self, apiKey: API_KEY, apiToken: API_TOK, styles: styles)
    }
    
    
    @IBAction func enrollment(){
        print("hello")
        myVoiceIt?.encapsulatedVoiceEnrollUser(userId, contentLanguage: language, voicePrintPhrase: phrase, userEnrollmentsCancelled: {
            print("User Enrollment Cancelled")
        }, userEnrollmentsPassed: {_ in
            print("User Enrollments Passed")
        })
    }
    
    @IBAction func verify(){
        myVoiceIt?.encapsulatedVoiceVerification(userId, contentLanguage: language, voicePrintPhrase: phrase, userVerificationCancelled: {
            print("User Cancelled Verification");
        }, userVerificationSuccessful: {(voiceConfidence, jsonResponse) in
            print("User Verication Successful, voiceConfidence : \(voiceConfidence)")
        }, userVerificationFailed: { (voiceConfidence, jsonResponse) in
            print("User Verication Failed, voiceConfidence : \(voiceConfidence)")
        })
    }

    
    //        myVoiceIt?.encapsulatedVoiceVerification(userId, contentLanguage: language, voicePrintPhrase: phrase, userVerificationCancelled: {
    //            print("User Cancelled Verification");
    //        }, userVerificationSuccessful: {(voiceConfidence, jsonResponse) in
    //            print("User Verication Successful, voiceConfidence : \(voiceConfidence)")
    //        }, userVerificationFailed: { (voiceConfidence, jsonResponse) in
    //            print("User Verication Failed, voiceConfidence : \(voiceConfidence)")
    //        })
    
    @IBAction func showMessage(sender: UIButton) {
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

