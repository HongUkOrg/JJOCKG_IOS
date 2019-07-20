//
//  LetterController.swift
//  letter_mouse
//
//  Created by mac on 31/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


class LetterController {


    static let getInstance : LetterController = LetterController()
    
    var latitude : Double
    var longitude : Double
    var what3Words : String
    var isSending : Bool
    var isTrackingLetterNow : Bool?
    var findedLetterContent : String?
    var findedLetterLati : Double?
    var findedLetterLong : Double?
    var receiverPhoneNumber : String?
    
    var LetterSaveDismissDelegate : ModalDimissDelegate_save?
    var LetterFindDismissDelegate : ModalDimissDelegate_find?
    var canLetterReadDelegate : CanLetterReadDelegate?
    var updateMainVewStateDelegate : UpdateMainViewStateDelegate?
 

    
    public func setLetterSaveDismissDelegate(_ delegate : ModalDimissDelegate_save){
        self.LetterSaveDismissDelegate = delegate
    }
    func setLetterFindDismissDelegate(_ delegate : ModalDimissDelegate_find){
        self.LetterFindDismissDelegate = delegate
    }
    func setCanOpenLetterDelegate(_ delegate : CanLetterReadDelegate ){
        self.canLetterReadDelegate = delegate
    }
    func setUpdateMainVewStateDelegate(_ delegate : UpdateMainViewStateDelegate ){
        self.updateMainVewStateDelegate = delegate
    }
    
    private init(){
        self.latitude = 0
        self.longitude = 0
        self.what3Words = ""
        self.LetterSaveDismissDelegate = nil
        self.isSending = false
    }
    

    

}
