//
//  ViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 29/03/2021.
//

import UIKit
import VoiceIt2_IosSDK
import FirebaseFirestore


class ViewController: UIViewController {
    var myVoiceIt:VoiceItAPITwo?
    
    let API_KEY = "key_c5f8c444d0504af49de136f3ce12b62a";
    let API_TOK = "tok_4fd9e0c54a584c7598cd047f74846760";
//    let language = "en-US";
    let language = "no-STT";
    let phrase = "hello i am very happy today";
    //let userId = "usr_9f4b211a85b24b0886ffdc82b8f54bf9";
    let username = "test1"
    // MARK: Outelts
    
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var inscriptionButton: UIButton!
    @IBOutlet weak var deconnectionButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var TestButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
        /* Reference to ViewController , API Credentials and styles dictionary*/
        let styles = NSMutableDictionary(dictionary: ["kThemeColor":"#FBC132","kIconStyle":"default"])
        self.myVoiceIt = VoiceItAPITwo(self, apiKey: API_KEY, apiToken: API_TOK, styles: styles)
    }
    
    
    // MARK : Private functions
    fileprivate func buttonDesign(button: UIButton) {
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.orange.cgColor
    }
    
    private func setupButtons() {
        if (connexionButton != nil) {
            buttonDesign(button: connexionButton)
        }
        if (inscriptionButton != nil) {
            buttonDesign(button: inscriptionButton)
        }
        
    }
    
    // MARK : Actions

    
    

    
    fileprivate func authenticateVoiceIt(userId:String) {
        myVoiceIt?.encapsulatedVoiceVerification(userId, contentLanguage: language, voicePrintPhrase: phrase, userVerificationCancelled: {
            print("User Cancelled Verification");
        }, userVerificationSuccessful: {(voiceConfidence, jsonResponse) in
            print("User Verication Successful, voiceConfidence : \(voiceConfidence)")
            self.displayConnectedPage()
        }, userVerificationFailed: { (voiceConfidence, jsonResponse) in
            print("User Verication Failed, voiceConfidence : \(voiceConfidence)")
        })
    }
    
    @IBAction func verification(){
    
        let userList = Firestore.firestore().collection("utilisateurs").whereField("username", isEqualTo: username)
        
        userList.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print(document.get("userID")!)
                        self.authenticateVoiceIt(userId: document.get("userID") as! String)
                    }
                }
        }

        
        
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
    
    
    @IBAction func showMessage(sender: UIButton) {
        let alertController = UIAlertController(title: "Welcome to our First App", message: "Hello ! It's Kenan and Fayçal !", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    fileprivate func swapViewController(identifier:String) {
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        newViewController.modalTransitionStyle = .crossDissolve
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func displayConnectedPage(){
        swapViewController(identifier: "connected_vc")
    }
    
    @IBAction func displayRegistrationPage(){
        swapViewController(identifier: "registration_vc")
    }
    
    @IBAction func returnDisplayHomePage(){
        swapViewController(identifier: "home_vc")
    }
    
    @IBAction func displayInformationPage(){
        swapViewController(identifier: "information_vc")
    }
    
}






