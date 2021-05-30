//
//  RegistrationViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 29/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegistrationViewController: ViewController, UITextFieldDelegate {


    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var NextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup1Buttons()
        setup1TextFieldManager()
        // Do any additional setup after loading the view.
    }
    
    private func create_VoiceIT_user(){
        myVoiceIt?.createUser({
            jsonResponse in
            print("JSON RESPONSE: \(jsonResponse!)")
        })
    }
    

    
    
    @IBAction func enrollment(){
        //Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordTextField.text!) { authResult, error in
               // [START_EXCLUDE]
          //       guard let user = authResult?.user, error == nil else {
            //       print(error!.localizedDescription)
            //       return
            //     }
            //     print("\(user.email!) created")
            //     self.navigationController?.popViewController(animated: true)
               // [END_EXCLUDE]
            // }
             // [END create_user]
        let collection = Firestore.firestore().collection("utilisateurs")
        let utilisateur = Utilisateurs(
          username: UsernameTextField.text!,
          email: EmailTextField.text!,
          password: PasswordTextField.text!,
          userID: "usr_0caa14ac5fb64ebdb32bcf515ed948c4"
        )

        myVoiceIt?.encapsulatedVoiceEnrollUser("usr_0caa14ac5fb64ebdb32bcf515ed948c4", contentLanguage: language, voicePrintPhrase: phrase, userEnrollmentsCancelled: {
            print("ANNULERRRRRRR")
            self.displayConnectedPage()
        }, userEnrollmentsPassed: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5,
                                          execute: {
                                            print("FONCTIONNE")
                                            self.dismiss(animated: true, completion: {
                                                collection.addDocument(data: utilisateur.dictionary)
                                                self.displayConnectedPage()
                                                        })
                                            })

        })
    }
    
    
    fileprivate func buttonDesign(button: UIButton) {
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.orange.cgColor
    }
    
    
    private func setup1Buttons(){
        if (NextStepButton != nil) {
            buttonDesign(button: NextStepButton)
        }
        
    }

    
    private func setup1TextFieldManager() {
        UsernameTextField.delegate = self
        if (EmailTextField != nil) {
            EmailTextField.delegate = self
        }
        if PasswordTextField != nil {
            PasswordTextField.delegate = self
        }
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard(){
        UsernameTextField.resignFirstResponder()
        EmailTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
    
    
    var RegistrationViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
         return true
            
        }
        return 0 as! UITextFieldDelegate
    }
}
