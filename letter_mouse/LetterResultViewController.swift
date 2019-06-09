//
//  LetterResultViewController.swift
//  letter_mouse
//
//  Created by mac on 08/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LetterResultViewController: UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let resultText = LetterController.getInstace.findLetterResult {
            resultTextView.text = resultText
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
