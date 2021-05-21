//
//  ConnexionController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 21/05/2021.
//

import UIKit

class ConnexionController: UIViewController {

    
    // MARK: Outelts
    
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var inscriptionButton: UIButton!
    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }

    // MARK : Private functions
    private func setupButtons() {
        connexionButton.layer.cornerRadius = 20
    
    }
    
    // MARK : Actions
    

}

