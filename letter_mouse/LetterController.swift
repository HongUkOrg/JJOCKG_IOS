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
    var latitude : String
    var longitude : String
    var what3Words : String
    var LetterSaveDismissDelegate : ModalDimissDelegate?
    
    public func setLetterSaveDismissDelegate(delegate : ModalDimissDelegate){
        self.LetterSaveDismissDelegate = delegate
    }
    
    private init(){
        self.latitude = ""
        self.longitude = ""
        self.what3Words = ""
        self.LetterSaveDismissDelegate = nil
    }
    

    

}
