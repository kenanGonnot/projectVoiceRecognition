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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* Reference to ViewController , API Credentials and styles dictionary*/
        
        let styles = NSMutableDictionary(dictionary: ["kThemeColor":"#FBC132","kIconStyle":"default"])
        self.myVoiceIt = VoiceItAPITwo(self, apiKey: API_KEY, apiToken: API_TOK, styles: styles)
        
        myVoiceIt?.encapsulatedVoiceEnrollUser("USER_ID_HERE", contentLanguage: "CONTENT_LANGUAGE_HERE", voicePrintPhrase: "my face and voice identify me", userEnrollmentsCancelled: {
            print("User Enrollment Cancelled")
        }, userEnrollmentsPassed: {_ in 
            print("User Enrollments Passed")
        })

    }

}

