//
//  SaveLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 01/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ContactsUI


class SaveLetterViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var contact: UIButton!
    @IBOutlet var saveLetterMainView: UIView!
    @IBOutlet weak var saveLetterView: UIView!
    @IBOutlet weak var sendLetterBtn: UIButton!
    @IBOutlet weak var sendLetterCancelBtn: UIButton!
    @IBOutlet weak var saveLetterWhiteView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendLetterBtnClicked(_ sender: UIButton) {

        LetterController.getInstance.savedWhat3Words = LetterController.getInstance.currentWhat3Words
        LetterController.getInstance.isSending = false
        LetterController.getInstance.receiverPhoneNumber = phoneNumber.text
        
        var json : [String:String] = [String:String]()
        let lati = String(format:"%f",LetterController.getInstance.latitude)
        let long = String(format:"%f",LetterController.getInstance.longitude)
        if lati != "" && long != "" {
            json["latitude"] = lati
            json["longitude"] = long
            json["message"] = contentTextView.text
            json["w3w_address"] = LetterController.getInstance.currentWhat3Words
            json["receiver_phone"] = phoneNumber.text

        }
        HttpConnectionHandler.getInstance.httpUrlConnection(isSave: true, json: json)
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        LetterController.getInstance.isSending = false
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            print("update main view from save letter controller")
            delegate.updateMainViewState()
        }
        self.dismiss(animated: true, completion: nil)
        print("cancel btn clicekd")
    }
    
    @IBAction func contactBtnClicked(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: CNContact) {
        let number = contacts.phoneNumbers
        for selectedNumber in number {
            phoneNumber.text = "\(selectedNumber.value.stringValue)"
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
   
}
