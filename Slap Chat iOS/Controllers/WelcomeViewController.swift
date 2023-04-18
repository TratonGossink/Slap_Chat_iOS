//
//  WelcomeViewController.swift
//  Slap_Chat_iOS
//
//  Created by Traton Gossink on 4/14/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){
                (timer) in
                self.titleLabel.text?.append(letter)
            }
                charIndex += 1
        }
    }
    

}
