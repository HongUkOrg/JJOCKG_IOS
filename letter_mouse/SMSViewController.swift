//
//  SMSViewController.swift
//  letter_mouse
//
//  Created by mac on 06/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SMSViewController: UIViewController {

    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var SMSSendBtn: UIButton!
    @IBOutlet weak var SMSCancelBtn: UIButton!
    @IBOutlet weak var yellowLetterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SMS send View Controller loaded!")
        
        yellowLetterView.layer.cornerRadius = 18
        yellowLetterView.clipsToBounds = true
        
        superWhiteView.layer.cornerRadius = 18
        superWhiteView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func SMSCancelBtnClick(_ sender: UIButton) {
       
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            delegate.updateMainViewState()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
