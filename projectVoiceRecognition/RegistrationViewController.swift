//
//  RegistrationViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 29/05/2021.
//

import UIKit

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
    
    private func setup1Buttons(){
        NextStepButton.layer.cornerRadius = 20
        NextStepButton.layer.borderWidth = 3
        NextStepButton.layer.borderColor = UIColor.orange.cgColor
    }

    
    private func setup1TextFieldManager() {
        UsernameTextField.delegate = self
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
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
