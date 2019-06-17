//
//  LetterController.swift
//  letter_mouse
//
//  Created by mac on 31/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


class LetterController {


    static let getInstace : LetterController = LetterController()
    
    var latitude : Double
    var longitude : Double
    var what3Words : String
    var isSending : Bool
    var findedLetterContent : String?
    var findedLetterLati : Double?
    var findedLetterLong : Double?
    
    var LetterSaveDismissDelegate : ModalDimissDelegate_save?
    var LetterFindDismissDelegate : ModalDimissDelegate_find?

    
    public func setLetterSaveDismissDelegate(_ delegate : ModalDimissDelegate_save){
        self.LetterSaveDismissDelegate = delegate
    }
    func setLetterFindDismissDelegate(_ delegate : ModalDimissDelegate_find){
        self.LetterFindDismissDelegate = delegate
    }
    
    private init(){
        self.latitude = 0
        self.longitude = 0
        self.what3Words = ""
        self.LetterSaveDismissDelegate = nil
        self.isSending = false
    }
    

    

}
