//
//  SMSFindViewController.swift
//  letter_mouse
//
//  Created by David Park on 31/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SMSFindViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var ok_btn: UIButton!
    
    @IBOutlet weak var pastTextView: UITextView!
    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var yellowView: UIView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        cancelBtn.addRoundnessShadowToButton(cornerRadius: 18)
        superWhiteView.addRoundness(cornerRadius: 18)
        yellowView.addRoundness(cornerRadius: 18)
        pastTextView.delegate = self
        pastTextView.text = "붙여넣기"
        pastTextView.textColor = UIColor.lightGray
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
    @IBAction func ok_btn_clicked(_ sender: Any) {
        if let paste = pastTextView.text {
            var json : Dictionary<String,String> = Dictionary<String,String>()
            
            var splistArr = paste.components(separatedBy: "\n")
            if splistArr.count != 4 {
                NSLog("Invaild jjockG SMS")
                return
            }
            json["receiver_phone"] = splistArr[1]
            json["w3w_address"] = splistArr[2]
            
            self.dismiss(animated: true, completion: nil)
            HttpConnectionHandler.getInstance.httpUrlConnection(isSave:false, json: json)
        }
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}
