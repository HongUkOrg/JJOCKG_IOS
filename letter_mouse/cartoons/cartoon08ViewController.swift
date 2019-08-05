//
//  cartoon04ViewController.swift
//  letter_mouse
//
//  Created by mac on 27/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class cartoon08ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.performSegue(withIdentifier: "toMain", sender: self)
        })
    }
    
    @IBAction func skipBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainLetterView") as! LetterMainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
