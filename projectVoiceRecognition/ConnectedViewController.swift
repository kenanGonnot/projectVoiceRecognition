//
//  ConnectedViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 23/05/2021.
//

import UIKit

class ConnectedViewController: ViewController {

    @IBOutlet weak var usernameLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUsername(username:String){
        usernameLabel.text = username
    }
    
    


}
