//
//  LetterProtocol.swift
//  letter_mouse
//
//  Created by mac on 09/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

public protocol ModalDimissDelegate_save{
    func didReceiveDismiss_save()
}
public protocol ModalDimissDelegate_find{
    func didReceiveDismiss_find(_ success : Bool)
}

protocol W3WResponseDelegate{
    func processResult(_ result : String)
}
protocol FindLetterResultDelegate{
    func processFindLetterResult(_ result : String)
}
class LetterProtocol: NSObject {

    

}
