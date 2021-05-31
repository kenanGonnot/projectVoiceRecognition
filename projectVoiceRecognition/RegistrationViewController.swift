//
//  RegistrationViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 29/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegistrationViewController: ViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var NextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup1Buttons()
        setup1TextFieldManager()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enrollment(){
        UserDefaults.standard.set(UsernameTextField.text!, forKey: "username")
        create_VoiceIT_userID()
    }
    
    private func create_VoiceIT_userID(){
        myVoiceIt?.createUser({
            jsonResponse in
            let data = Data(jsonResponse!.utf8)
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                if let userID = dictionary["userId"] as? String {
                    DispatchQueue.main.asyncAfter(deadline: .now(),
                                                  execute: {
                                                    self.save_user_voice(newUserID: userID)
                                                  })
                }
            }
        })
    }

    fileprivate func save_user_voice(newUserID:String) {
        myVoiceIt?.encapsulatedVoiceEnrollUser(newUserID, contentLanguage: language, voicePrintPhrase: phrase, userEnrollmentsCancelled: {
            print("ANNULERRRRRRR")
        }, userEnrollmentsPassed: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5,
                                          execute: {
                                            print("FONCTIONNE")
                                            self.dismiss(animated: true, completion: {
                                                self.save_in_firestore(newUserID: newUserID)
                                                self.displayConnectedPage(username: self.UsernameTextField.text!)
                                            })
                                          })
            
        })
    }
    
    fileprivate func save_in_firestore(newUserID:String) {
        let collection = Firestore.firestore().collection("utilisateurs")
        let utilisateur = Utilisateurs(
            username: UsernameTextField.text!,
            email: EmailTextField.text!,
            password: PasswordTextField.text!,
            userID: newUserID
        )
        collection.addDocument(data: utilisateur.dictionary)
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
        if EmailTextField != nil {
            EmailTextField.resignFirstResponder()
        }
        
        if PasswordTextField != nil {
            PasswordTextField.resignFirstResponder()
        }
    }
    
    
    var RegistrationViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
            
        }
        return 0 as! UITextFieldDelegate
    }
}
