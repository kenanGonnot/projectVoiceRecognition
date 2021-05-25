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
    
    // MARK: Outelts
    
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var inscriptionButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
        /* Reference to ViewController , API Credentials and styles dictionary*/
        let styles = NSMutableDictionary(dictionary: ["kThemeColor":"#FBC132","kIconStyle":"default"])
        self.myVoiceIt = VoiceItAPITwo(self, apiKey: API_KEY, apiToken: API_TOK, styles: styles)
    }
    
    
    // MARK : Private functions
    private func setupButtons() {
        connexionButton.layer.cornerRadius = 20
    
    }
    
    // MARK : Actions

    
    
    @IBAction func enrollment(){
        print("hello")
        myVoiceIt?.encapsulatedVoiceEnrollUser(userId, contentLanguage: language, voicePrintPhrase: phrase, userEnrollmentsCancelled: {
            print("User Enrollment Cancelled")
        }, userEnrollmentsPassed: {_ in
            print("User Enrollments Passed")
        })
    }
    
    @IBAction func verification(){
        myVoiceIt?.encapsulatedVoiceVerification(userId, contentLanguage: language, voicePrintPhrase: phrase, userVerificationCancelled: {
            print("User Cancelled Verification");
        }, userVerificationSuccessful: {(voiceConfidence, jsonResponse) in
            print("User Verication Successful, voiceConfidence : \(voiceConfidence)")
            self.displayConnectedPageAction()
        }, userVerificationFailed: { (voiceConfidence, jsonResponse) in
            print("User Verication Failed, voiceConfidence : \(voiceConfidence)")
        })
    }


    @IBAction func create_user(){
        myVoiceIt?.createUser({
            jsonResponse in
            print("JSON RESPONSE: \(jsonResponse!)")
        })
    }
    
    @IBAction func create_group(){
        myVoiceIt?.createGroup("Groupe ESME", callback: {
            jsonResponse in
        })
    }
    
    @IBAction func add_usr_to_grp(usr_:String , grp_:String){
        myVoiceIt?.addUser(toGroup: grp_, userId: usr_, callback: {
            jsonResponse in
            print("JSON RESPONSE: \(jsonResponse!)")
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
        let alertController = UIAlertController(title: "Welcome to our First App", message: "Hello ! It's Kenan and Fayçal !", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func displayConnectedPageAction(){
        guard let vc = storyboard?.instantiateViewController(identifier: "connected_vc") as? ConnectedViewController else {
            return 
        }
        present(vc, animated: true)
    }
    
}






