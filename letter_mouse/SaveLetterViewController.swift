//
//  SaveLetterViewController.swift
//  letter_mouse
//
//  Created by mac on 01/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Presentr




class SaveLetterViewController: UIViewController {

    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var contact: UIButton!
    @IBOutlet var saveLetterMainView: UIView!
    @IBOutlet weak var saveLetterView: UIView!
    @IBOutlet weak var sendLetterBtn: UIButton!
    @IBOutlet weak var sendLetterCancelBtn: UIButton!
    @IBOutlet weak var saveLetterWhiteView: UIView!

    
    static let presenter : Presentr = {
        let width = ModalSize.custom(size: Float(UIScreen.main.bounds.width*0.9))
        let height = ModalSize.custom(size:Float(UIScreen.main.bounds.height*0.75))
        let center = ModalCenterPosition.custom(
            centerPoint: CGPoint.init(
                x: UIScreen.main.bounds.width*0.5,
                y: UIScreen.main.bounds.height*0.625
        ))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .coverVertical
        customPresenter.dismissAnimated = true
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.backgroundOpacity = 0
        
        
        return customPresenter
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        phoneNumber.addShadowToTextField(cornerRadius: 18)
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

        LetterController.getInstance.isSending = false
        
        var json : [String:String] = [String:String]()
        let lati = String(format:"%f",LetterController.getInstance.latitude)
        let long = String(format:"%f",LetterController.getInstance.longitude)
        if lati != "" && long != "" {
            json["latitude"] = lati
            json["longitude"] = long
            json["message"] = contentTextView.text
            json["w3w_address"] = LetterController.getInstance.what3Words
            json["receiver_phone"] = phoneNumber.text

        }
        HttpConnectionHandler.getInstance.httpUrlConnection(isSave:true, json: json)
        
        dismiss(animated: true, completion: nil)

        let controller2 = self.storyboard?.instantiateViewController(withIdentifier: "SMSSendViewController") as! SMSViewController
        customPresentViewController(SaveLetterViewController.presenter , viewController:controller2, animated: true,completion: {
            print("SMS Send View Controller complete")
        })
        
        if let delegate : ModalDimissDelegate_save = LetterController.getInstance.LetterSaveDismissDelegate {
            delegate.didReceiveDismiss_save()
        }
        dismissFunc()

    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        if let delegate = LetterController.getInstance.updateMainVewStateDelegate{
            print("update main view from save letter controller")
            delegate.updateMainViewState()
        }
        self.dismiss(animated: true, completion: nil)
        print("cancel btn clicekd")
    }
    
    func dismissFunc(){
    }
}
