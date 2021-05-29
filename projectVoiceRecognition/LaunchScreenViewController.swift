//
//  LaunchScreenViewController.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 28/05/2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var inscriptionButton: UIButton!


    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }

    private func animate() {
            UIView.animate(withDuration: 1, animations: {
                let size = self.view.frame.size.width * 3
                let diffX = size - self.view.frame.size.width
                let diffY = self.view.frame.size.height - size
                
                self.imageView.frame = CGRect(
                    x: -(diffX/2),
                    y: diffY/2,
                    width: size,
                    height: size
                )
            })
            
            UIView.animate(withDuration: 1.5, animations: {
                self.imageView.alpha = 0.5
            }, completion: { done in
                if done{
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "home_vc") as! ViewController
                        newViewController.modalTransitionStyle = .crossDissolve
                        newViewController.modalPresentationStyle = .fullScreen
                                self.present(newViewController, animated: true, completion: nil)
                    })
                }
            })
        



}
}
