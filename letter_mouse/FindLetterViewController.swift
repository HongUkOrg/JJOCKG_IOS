//
//  FindLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 16/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ContactsUI

class FindLetterViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func contactBtnClicked(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        self.present(cnPicker, animated: true, completion: nil)
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: CNContact) {
        let number = contacts.phoneNumbers
        for selectedNumber in number {
//            numberInputTextField.text = "\(selectedNumber.value.stringValue)"
        }
    }
}
