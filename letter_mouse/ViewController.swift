//
//  ViewController.swift
//  letter_mouse
//
//  Created by mac on 23/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
         self.navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000) ) {
            self.performSegue(withIdentifier: "toCartoonContainer", sender: self)
        }
    }
    @IBOutlet var splashView: UIView!
    

}
