//
//  LetterResultViewController.swift
//  letter_mouse
//
//  Created by mac on 08/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation

class LetterResultViewController: UIViewController {
    
    @IBOutlet var superMainView: UIView!
    @IBOutlet weak var mainUiView: UIView!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var underOpenBtn: UIButton!
    
    var isOpend : Bool = false
    var letterHeight : CGFloat?
    
    
    @IBAction func underOpenBtnClicked(_ sender: UIButton) {
        
        if canOpenLetter(){
            if !isOpend {
                let originalTransform = self.mainUiView.transform
                let scaledTransform = originalTransform.translatedBy(x: 0.0, y: +(letterHeight ?? 500) * 0.5)
                UIView.animate(withDuration: 0.7, animations: {
                    self.mainUiView.transform = scaledTransform
                })
                self.isOpend = !self.isOpend
            }
            else {
                let originalTransform = self.mainUiView.transform
                let scaledTransform = originalTransform.translatedBy(x: 0.0, y: -(letterHeight ?? 500) * 0.5)
                UIView.animate(withDuration: 0.7, animations: {
                    self.mainUiView.transform = scaledTransform
                })
                self.isOpend = !self.isOpend
            }
        }
        else {
            print("under open btn clicekd ... : can not open")
        }
        
        
    }
    
    @IBAction func underCancleBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterHeight = mainUiView.frame.height
        
        superMainView.addRoundness(cornerRadius: 18)
        mainUiView.addRoundness(cornerRadius : 18)
        underView.addRoundness(cornerRadius : 18)
        
        
        if let resultText = LetterController.getInstace.findedLetterContent {
            print("unoptional result text \(resultText)")
            let attributedString = NSMutableAttributedString(string: resultText)
            let paragraphStyle = NSMutableParagraphStyle()
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            mainTextView.attributedText = attributedString
            
            underOpenBtn.addShadowToButton()
            
        }
        
        setDefaultLetterState()

        // Do any additional setup after loading the view.
    }
    
    func canOpenLetter() -> Bool{
        let lamnentDistance = calculateDistance()
        if lamnentDistance <= 50.0 {
            print("can Open message \(lamnentDistance)")
            return true
        }
        else {
            print("can't open message, remained distance : \(lamnentDistance)")
            return false
        }
    }
    func calculateDistance() -> Double {
        let destinationCoordinate = CLLocation(latitude: LetterController.getInstace.findedLetterLati!,
                                               longitude: LetterController.getInstace.findedLetterLong!)
        let currentCoordinate = CLLocation(latitude: LetterController.getInstace.latitude,
                                           longitude: LetterController.getInstace.longitude)
        
        return destinationCoordinate.distance(from: currentCoordinate)
    }
    
    func setDefaultLetterState() {
        let originalTransform = self.mainUiView.transform
        let scaledTransform = originalTransform.translatedBy(x: 0.0, y: (letterHeight ?? 500) * 0.5)
        self.mainUiView.transform = scaledTransform
        self.isOpend = !self.isOpend
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
