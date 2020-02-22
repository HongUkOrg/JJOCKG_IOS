//
//  cartoon01ViewController.swift
//  letter_mouse
//
//  Created by mac on 26/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class cartoon01ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func skipClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainLetterView") as! LetterMainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    

}
