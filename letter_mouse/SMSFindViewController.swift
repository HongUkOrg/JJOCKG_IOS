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
    @IBOutlet weak var pasteBtn: UIButton!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        cancelBtn.addRoundnessShadowToButton(cornerRadius: 18)
        superWhiteView.addRoundness(cornerRadius: 18)
        yellowView.addRoundness(cornerRadius: 18)
        pastTextView.delegate = self
        pastTextView.text = "1. SMS로 전달받은 문자 전문을 복사해주세요!\n2. 붙여넣기 버튼 클릭!"
        pastTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        
        pasteBtn.addShadowToButton(height: 0.7)
        
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
            var json: Dictionary<String, String> = Dictionary<String, String>()
            
            let splistArr = paste.components(separatedBy: "\n")
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
    
    @IBAction func pasteBtnClicked(_ sender: Any) {
        let pb: UIPasteboard = UIPasteboard.general
        if let pastedString : String = pb.string, pastedString.hasPrefix("쪽지가 도착했습니다.") {
            pastTextView.text = pastedString
        }
    }
}
