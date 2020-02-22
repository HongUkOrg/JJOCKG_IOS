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

    var previousInputCount : Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideKeyboardWhenTappedAround()
        
        phoneNumber.addShadowToTextField(cornerRadius: 18)
        phoneNumber.keyboardType = UIKeyboardType.numberPad
        saveLetterWhiteView.addRoundness(cornerRadius :18)
        saveLetterView.addRoundness(cornerRadius :18)
        
        sendLetterCancelBtn.layer.cornerRadius = 18
        sendLetterCancelBtn.clipsToBounds = true
        sendLetterCancelBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        sendLetterCancelBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendLetterCancelBtn.layer.shadowOpacity = 1.0
        sendLetterCancelBtn.layer.shadowRadius = 0.0
        sendLetterCancelBtn.layer.masksToBounds = false
        
        sendLetterBtn.layer.cornerRadius = 18
        sendLetterBtn.clipsToBounds = true
        sendLetterBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        sendLetterBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendLetterBtn.layer.shadowOpacity = 1.0
        sendLetterBtn.layer.shadowRadius = 0.0
        sendLetterBtn.layer.masksToBounds = false
    
        
        
        print("view did load on save letter view controller")
        
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
        HttpConnectionHandler.getInstance.httpUrlConnection(isSave:true, json: json)
        
        dismiss(animated: true, completion: nil)
        
        if let delegate : ModalDimissDelegate_save = LetterController.getInstance.LetterSaveDismissDelegate {
            delegate.didReceiveDismiss_save()
        }
        dismissFunc()

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
    
    func dismissFunc(){
    }
    @IBAction func addDashToPhoneNumber(_ sender: Any) {
        var beforeChangeCount : Int = 0
        
        if let input = phoneNumber.text {
            beforeChangeCount = input.count
            switch input.count {
            case 3, 8:
                if previousInputCount == 2 || previousInputCount == 7{
                    phoneNumber.text = input + "-"
                }
            case 4:
                if(input[input.index(input.startIndex,offsetBy: 3)] == "-"){
                    break
                }
                var temp = input
                temp.insert("-", at: input.index(input.startIndex, offsetBy: 3))
                phoneNumber.text = temp
            case 9:
                if(input[input.index(input.startIndex,offsetBy: 8)] == "-"){
                    break
                }
                var temp = input
                temp.insert("-", at: input.index(input.startIndex, offsetBy: 8))
                phoneNumber.text = temp
            default:
                break
            }
        }
        previousInputCount = beforeChangeCount
    }
}
