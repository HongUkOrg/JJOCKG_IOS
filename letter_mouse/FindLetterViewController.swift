//
//  FindLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 16/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ContactsUI


class FindLetterViewController: UIViewController,FindLetterResultDelegate, CNContactPickerDelegate {
 
    
    @IBOutlet weak var firstWord: UITextField!
    @IBOutlet weak var secondWord: UITextField!
    @IBOutlet weak var thirdWord: UITextField!
    
    @IBOutlet weak var stackViewInW3W: UIStackView!
    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var numberInputTextField: UITextField!
    @IBOutlet weak var W3W_input_view: UIView!
    @IBOutlet weak var letterFindBtn: UIButton!
    @IBOutlet weak var SMS_findBtn: UIButton!
    
    private var previousInputCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
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
    }
    @IBAction func contactBtnClicked(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: CNContact) {
        let number = contacts.phoneNumbers
        for selectedNumber in number {
            numberInputTextField.text = "\(selectedNumber.value.stringValue)"
        }
    }
    @IBAction func findLetterBySMS(_ sender: Any) {
        if let delegate : ModalDimissDelegate_sms = LetterController.getInstance.smsFindDismissDeleagte {
            delegate.didReceiveDismiss_sms()
        }
    }
}
