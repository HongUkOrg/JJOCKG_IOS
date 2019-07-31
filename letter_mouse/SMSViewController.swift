//
//  SMSViewController.swift
//  letter_mouse
//
//  Created by mac on 06/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MessageUI

class SMSViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var firstWord: UILabel!
    @IBOutlet weak var secondWord: UILabel!
    @IBOutlet weak var thirdWord: UILabel!
    @IBOutlet weak var w3wResultView: UIView!
    @IBOutlet weak var superWhiteView: UIView!
    @IBOutlet weak var SMSSendBtn: UIButton!
    @IBOutlet weak var SMSCancelBtn: UIButton!
    @IBOutlet weak var yellowLetterView: UIView!
    @IBOutlet weak var resultPhoneNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SMS send View Controller loaded!")
        
        yellowLetterView.layer.cornerRadius = 18
        yellowLetterView.clipsToBounds = true
        
        superWhiteView.layer.cornerRadius = 18
        superWhiteView.clipsToBounds = true
        
        let borderColor : UIColor = UIColor( red: 0.265, green: 0.234, blue:0.082, alpha: 1.0 )
        w3wResultView.layer.borderWidth = 1.0
        w3wResultView.layer.borderColor = borderColor.cgColor
        w3wResultView.layer.cornerRadius = 18
        w3wResultView.clipsToBounds = true
        
        guard let savedW3W = LetterController.getInstance.savedWhat3Words else {
            return
        }
        let words : Array<Substring> = savedW3W.characters.split(separator: ".")
        if words.count == 3 {
            firstWord.text = "\(words[0])"
            secondWord.text = "\(words[1])"
            thirdWord.text = "\(words[2])"
        }
        
        resultPhoneNumber.layer.borderWidth = 1.0
        resultPhoneNumber.layer.borderColor = borderColor.cgColor
        resultPhoneNumber.layer.cornerRadius = 18
        resultPhoneNumber.clipsToBounds = true
        if let phoneNumber = LetterController.getInstance.receiverPhoneNumber {
            resultPhoneNumber.text = phoneNumber
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
    @IBAction func smsSendBtnClicked(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available")
            self.dismiss(animated: true, completion: nil)
        }
        else {
            var content : String = "쪽지가 도착했습니다.\n" + LetterController.getInstance.receiverPhoneNumber!+"\n"
            content += LetterController.getInstance.savedWhat3Words!
            content += "\n-쪽쥐-"
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = [LetterController.getInstance.receiverPhoneNumber!]
            composeVC.body = content
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
            print("SMS can available")
        }
    }
    @IBAction func SMSCancelBtnClick(_ sender: UIButton) {
       
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            delegate.updateMainViewState()
        }  
        dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            delegate.updateMainViewState()
        }
        print("sms dimiss")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
