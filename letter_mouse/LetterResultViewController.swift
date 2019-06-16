//
//  LetterResultViewController.swift
//  letter_mouse
//
//  Created by mac on 08/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LetterResultViewController: UIViewController {
    
    @IBOutlet var superMainView: UIView!
    @IBOutlet weak var mainUiView: UIView!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var underOpenBtn: UIButton!
    
    
    @IBAction func underCancelBtnClicked(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superMainView.addRoundness(cornerRadius: 18)
        mainUiView.addRoundness(cornerRadius : 18)
        underView.addRoundness(cornerRadius : 18)

        
        
        if let resultText = LetterController.getInstace.findLetterResult {
            print("unoptional result text \(resultText)")
            let attributedString = NSMutableAttributedString(string: resultText)
            let paragraphStyle = NSMutableParagraphStyle()
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            mainTextView.attributedText = attributedString
            
            underOpenBtn.addShadowToButton()
            
        }

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
