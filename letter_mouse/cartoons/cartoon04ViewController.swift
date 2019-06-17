//
//  cartoon04ViewController.swift
//  letter_mouse
//
//  Created by mac on 27/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class cartoon04ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
                self.navigationController?.isNavigationBarHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet var splashView: UIView!
    
    @IBAction func skipBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainLetterView") as! LetterMainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
            print("Swipe Right")
            
        }
        else if gesture.direction == .left {
            performSegue(withIdentifier: "toCartoon05", sender: self)
            print("Swipe Left")
            
            
        }
    }

}
