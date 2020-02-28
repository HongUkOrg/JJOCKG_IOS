//
//  SMSFindViewController.swift
//  letter_mouse
//
//  Created by David Park on 31/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SMSFindViewController: UIViewController, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ok_btn_clicked(_ sender: Any) {
        let paste = ""
        var json: Dictionary<String, String> = Dictionary<String, String>()
        
        let splistArr = paste.components(separatedBy: "\n")
        if splistArr.count != 4 {
            NSLog("Invaild jjockG SMS")
            return
        }
        json["receiver_phone"] = splistArr[1]
        json["w3w_address"] = splistArr[2]
        
        self.dismiss(animated: true, completion: nil)
        
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
    
    @IBAction func pasteBtnClicked(_ sender: Any) {
        let pb: UIPasteboard = UIPasteboard.general
        if let pastedString : String = pb.string, pastedString.hasPrefix("쪽지가 도착했습니다.") {
        }
    }
}
