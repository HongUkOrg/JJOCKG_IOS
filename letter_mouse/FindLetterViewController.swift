//
//  FindLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 16/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


class FindLetterViewController: UIViewController {

    
    @IBOutlet weak var stackViewInW3W: UIStackView!
    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var numberInputTextField: UITextField!
    @IBOutlet weak var W3W_input_view: UIView!
    @IBOutlet weak var letterFindBtn: UIButton!
    @IBOutlet weak var SMS_findBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        numberInputTextField.addShadowToTextField(cornerRadius: 18)
        
        W3W_input_view.layer.cornerRadius = 18
        W3W_input_view.clipsToBounds = true
        
        superWhiteView.layer.cornerRadius = 18
        superWhiteView.clipsToBounds = true
        
        stackViewInW3W.layer.cornerRadius = 18
        stackViewInW3W.clipsToBounds = true
        
        
        
//        letterFindBtn.layer.cornerRadius = 18
//        letterFindBtn.clipsToBounds = true
//        letterFindBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        letterFindBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        letterFindBtn.layer.shadowOpacity = 1.0
//        letterFindBtn.layer.shadowRadius = 0.0
//        letterFindBtn.layer.masksToBounds = false
//
//        SMS_findBtn.layer.cornerRadius = 18
//        SMS_findBtn.clipsToBounds = true
//        SMS_findBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        SMS_findBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        SMS_findBtn.layer.shadowOpacity = 1.0
//        SMS_findBtn.layer.shadowRadius = 0.0
//        SMS_findBtn.layer.masksToBounds = false
        
        letterFindBtn.addRoundnessToButton(cornerRadius : 18)
        SMS_findBtn.addRoundnessToButton(cornerRadius : 18)
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

}
