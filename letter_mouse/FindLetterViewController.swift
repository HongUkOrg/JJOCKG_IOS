//
//  FindLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 16/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


class FindLetterViewController: UIViewController,FindLetterResultDelegate {
 
    
    @IBOutlet weak var firstWord: UITextField!
    @IBOutlet weak var secondWord: UITextField!
    @IBOutlet weak var thirdWord: UITextField!
    
    @IBOutlet weak var stackViewInW3W: UIStackView!
    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var numberInputTextField: UITextField!
    @IBOutlet weak var W3W_input_view: UIView!
    @IBOutlet weak var letterFindBtn: UIButton!
    @IBOutlet weak var SMS_findBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        numberInputTextField.addShadowToTextField(cornerRadius: 18)
        
        W3W_input_view.addRoundness(cornerRadius : 18)
        superWhiteView.addRoundness(cornerRadius : 18)
        stackViewInW3W.addRoundness(cornerRadius : 18)
        
        
        
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
        
        letterFindBtn.addRoundnessShadowToButton(cornerRadius : 18)
        SMS_findBtn.addRoundnessShadowToButton(cornerRadius : 18)
        // Do any additional setup after loading the view.
        
        HttpConnectionHandler.getInstance.setFindLetterResultDelegate(self)
    }
    
    @IBAction func findLetterBtnClicked(_ sender: UIButton) {
        
        var json : Dictionary<String,String> = Dictionary<String,String>() 
        
        if let firstWord = firstWord.text, let secondWord = secondWord.text, let thirdWord = thirdWord.text{
            json["w3w_address"] = firstWord + "." + secondWord + "." + thirdWord
        }
        if let phoneNumber = numberInputTextField.text {
            json["receiver_phone"] = phoneNumber
        }
        if json.count != 2 {
            return
        }
        HttpConnectionHandler.getInstance.httpUrlConnection(isSave:false, json: json)
        
        
    }
    
    @IBAction func findLetterBySMSBtnClicked(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func processFindLetterResult(_ result: String) {
        print("process find letter result : \(result)")
        
        if let dict = LetterUtils.convertToDictionary(result){
            if let letterContent = dict["letter"] as? [[String:String]] {
                let json = letterContent[letterContent.startIndex]
                if let message = json["message"], let lati = json["latitude"], let long = json["longitude"] {
                    print("store letter content : \(String(describing: json["message"]))")
                    LetterController.getInstance.findedLetterContent = message
                    LetterController.getInstance.findedLetterLati = Double(lati)
                    LetterController.getInstance.findedLetterLong = Double(long)

                    callBackResultToMain(true)
                }
                else {
                    callBackResultToMain(false)
                }
            }
        }
        
    }
    func callBackResultToMain(_ success : Bool){
        if let delegate : ModalDimissDelegate_find = LetterController.getInstance.LetterFindDismissDelegate as! ModalDimissDelegate_find {
            delegate.didReceiveDismiss_find(success)
        }
        dismissFunc()
    }
    func dismissFunc(){
        dismiss(animated: true, completion: nil)
    }

}
