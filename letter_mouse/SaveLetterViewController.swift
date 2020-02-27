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


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func contactBtnClicked(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: CNContact) {
        let number = contacts.phoneNumbers
        for selectedNumber in number {
//            phoneNumber.text = "\(selectedNumber.value.stringValue)"
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
   
}
