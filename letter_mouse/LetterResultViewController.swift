//
//  LetterResultViewController.swift
//  letter_mouse
//
//  Created by mac on 08/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation

class LetterResultViewController: UIViewController, CanLetterReadDelegate {
    
    @IBOutlet var superMainView: UIView!
    @IBOutlet weak var mainUiView: UIView!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var underOpenBtn: UIButton!
    
    var isOpend : Bool = false
    var letterHeight : CGFloat?
    var canOpenLetter : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterHeight = mainUiView.frame.height
        
        superMainView.addRoundness(cornerRadius: 18)
        mainUiView.addRoundness(cornerRadius : 18)
        underView.addRoundness(cornerRadius : 18)
        
        
        if let resultText = LetterController.getInstance.findedLetterContent {
            print("unoptional result text \(resultText)")
            let attributedString = NSMutableAttributedString(string: resultText)
            let paragraphStyle = NSMutableParagraphStyle()
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            mainTextView.attributedText = attributedString
            
            underOpenBtn.addShadowToButton()
            
        }
        
        LetterController.getInstance.setCanOpenLetterDelegate(self)
        setDefaultLetterState()
        notifyToUpdateMainViewState()
        
    }
    
    
    func setDefaultLetterState() {
        let originalTransform = self.mainUiView.transform
        let scaledTransform = originalTransform.translatedBy(x: 0.0, y: (letterHeight ?? 500) * 0.5)
        self.mainUiView.transform = scaledTransform
        self.isOpend = false
        
        underOpenBtn.backgroundColor = UIColor(red: 0.7, green: 0.7, blue:0.7, alpha: 1)
        LetterController.getInstance.isTrackingLetterNow = true
    }
    
    func enableLetterReading(_ canOpen : Bool){
        if canOpen {
        self.canOpenLetter = true
        underOpenBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    @IBAction func underOpenBtnClicked(_ sender: UIButton) {
        if !canOpenLetter {
            return
        }
        if isOpend {
            let originalTransform = self.mainUiView.transform
            let scaledTransform = originalTransform.translatedBy(x: 0.0, y: +(letterHeight ?? 500) * 0.5)
            UIView.animate(withDuration: 0.7, animations: {
                self.mainUiView.transform = scaledTransform
            })
            self.isOpend = false
            self.underOpenBtn.setTitle("쪽지 열어보기", for: .normal)
        }
        else {
            let originalTransform = self.mainUiView.transform
            let scaledTransform = originalTransform.translatedBy(x: 0.0, y: -(letterHeight ?? 500) * 0.5)
            UIView.animate(withDuration: 0.7, animations: {
                self.mainUiView.transform = scaledTransform
            })
            self.isOpend = true
            self.underOpenBtn.setTitle("쪽지 닫기", for: .normal)
        }
        
    }
    
    
    @IBAction func underCancleBtnClicked(_ sender: UIButton) {
        LetterController.getInstance.isTrackingLetterNow = false
        notifyToUpdateMainViewState()
        self.canOpenLetter = false
        self.dismiss(animated: true, completion: nil)
    }
    func notifyToUpdateMainViewState(){
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            delegate.updateMainViewState()
        }
    }

}
