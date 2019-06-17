//
//  LetterMainViewController.swift
//  letter_mouse
//
//  Created by mac on 31/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import Presentr




class LetterMainViewController: UIViewController, CLLocationManagerDelegate, ModalDimissDelegate_save,ModalDimissDelegate_find, W3WResponseDelegate, UpdateMainViewStateDelegate {

    
    let locationManager = CLLocationManager()
    var currentLatitude : Double?
    var currentLongitude : Double?
    @IBOutlet fileprivate weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var w3w_text: UITextField!
    @IBOutlet weak var sendLetterBtn: UIButton!
    @IBOutlet weak var sendLetterCancelBtn: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mainUpperYellowView: UIView!
    @IBOutlet weak var mainUpperWhiteView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    
    static let getInstance : LetterMainViewController = LetterMainViewController()
    public var dismissDelegate : ModalDimissDelegate_save?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main View Acitivity View Did Load!!!")
        updateViewState()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.4980, longitude: 127.0761, zoom: 18.0)
        googleMapView.camera = camera
        //        view = mapView
        
        w3w_text.layer.cornerRadius = 18
        w3w_text.clipsToBounds = true
        
        LetterController.getInstance.setLetterSaveDismissDelegate(self)
        LetterController.getInstance.setLetterFindDismissDelegate(self)
        LetterController.getInstance.setUpdateMainVewStateDelegate(self)
        HttpConnectionHandler.getInstance.setW3WResponseDelegate(self)
        
    }
    
    func didReceiveDismiss_save() {
        print("MainViewController : called save didReceiveDismiss func")
        
        updateViewState()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
            self.showSMSView()
        }
        
    }
    func didReceiveDismiss_find(_ success : Bool) {
        print("MainViewController : called find didReceiveDismiss func")
        
        updateViewState()
        if success{
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
                self.showLetterResultView()
            }
        }
        else {
            print("ERROR :: find fail!!!!!!!")
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        updateViewState()
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        googleMapView.clear()
        let marker = GMSMarker()
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 18.0)
        
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "CurrentPosition"
        marker.snippet = "Letter"
        marker.icon = UIImage(named: "current_letter")
        
        googleMapView.camera = camera
        marker.map = googleMapView
        
        currentLatitude = locValue.latitude
        currentLongitude = locValue.longitude
        HttpConnectionHandler.getInstance.getWhat3WordsFromGPS(
            latitude: String(format:"%f",currentLatitude!),
            longitude: String(format:"%f",currentLongitude!)
        )
        LetterController.getInstance.latitude = currentLatitude!
        LetterController.getInstance.longitude = currentLongitude!

        
        if let isTrackingNow = LetterController.getInstance.isTrackingLetterNow, isTrackingNow {
            setLetterTrackingMode()
            var calculatedDistance = calculateDistance()
            var distanceMsg = String(Int(calculatedDistance)) + "m 남았습니다"
            self.distanceLabel.text = distanceMsg
            if let delegate = LetterController.getInstance.canLetterReadDelegate {
                if canOpenLetter(calculatedDistance)  {
                    callBackLetterTrackingView(true)
                }
                else {
                    callBackLetterTrackingView(false)
                }
            }
        }
        else {
            setNormalMode()
        }
        
        
    
    }
    
    func callBackLetterTrackingView(_ canOpen : Bool){
        if let delegate = LetterController.getInstance.canLetterReadDelegate {
            delegate.enableLetterReading(canOpen)
        }
        else {
            print("ERROR :: canLetterReadDelegate is not set yet")
        }
    }

    @IBAction func letterSaveBtn(_ sender: UIButton) {
        LetterController.getInstance.isSending = true
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SaveLetterViewController") as! SaveLetterViewController

        customPresentViewController(PresentrStore.getInstance.simplePresentR , viewController:controller, animated: true,completion: {
            self.stateLabel.text = "쪽지 남기기"
            print("complete")
        })
        
    
    }
    
    @IBAction func letterFindBtn(_ sender: UIButton) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "findLetterViewController") as! FindLetterViewController
        customPresentViewController(PresentrStore.getInstance.findPresentR , viewController:controller, animated: true,completion: {
            print("complete")
        })
    }
    func showSMSView(){
        
         let controller = self.storyboard?.instantiateViewController(withIdentifier: "SMSSendViewController") as! SMSViewController
        customPresentViewController(PresentrStore.getInstance.simplePresentR , viewController:controller, animated: true,completion: {
            self.stateLabel.text = "SMS로 보내기"
            print("complete")
        })
    }
    func showLetterResultView(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LetterResultViewController") as! LetterResultViewController
        customPresentViewController(PresentrStore.getInstance.letterResultpresentR , viewController:controller, animated: true,completion: {
            print("complete")
        })
    }
    
    func showSaveLetterView(view: UIView, hidden: Bool) {
        
        UIView.transition(with: view, duration: 1, options: .transitionFlipFromBottom ,animations: {
            view.isHidden = hidden
        })
    }
    func animateW3WTextView(offset : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState],
                       animations: {
                        self.w3w_text.frame.origin.y += UIScreen.main.bounds.height * offset
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    public func setDismissDelegate(delegate : ModalDimissDelegate_save ){
        self.dismissDelegate = delegate
    }
    
    
    func processResult(_ result: String) {
        let words = result.characters.split(separator: ".")
        if !LetterController.getInstance.isSending {
            LetterController.getInstance.what3Words = result
            w3w_text.text = "\(words[0]) \t / \t \(words[1]) \t / \t\(words[2])"
            print(result)
        }
    }
    
    func canOpenLetter(_ distance : Double) -> Bool{
        if distance <= 50.0 {
            print("can Open message, remained distance :\(distance)")
            return true
        }
        else {
            print("can't open message, remained distance : \(distance)")
            return false
        }
    }
    func calculateDistance() -> Double {
        let destinationCoordinate = CLLocation(latitude: LetterController.getInstance.findedLetterLati!,
                                               longitude: LetterController.getInstance.findedLetterLong!)
        let currentCoordinate = CLLocation(latitude: LetterController.getInstance.latitude,
                                           longitude: LetterController.getInstance.longitude)
        
        return destinationCoordinate.distance(from: currentCoordinate)
    }
    
    func updateViewState() {
        if let isTrakcing = LetterController.getInstance.isTrackingLetterNow, isTrakcing {
            setLetterTrackingMode()
        }
        else {
            setNormalMode()
        }
    }
    func setLetterTrackingMode(){
        DispatchQueue.main.async {
        self.stateLabel.text = "쪽지 찾기"
        self.w3w_text.isHidden = true
        self.mainUpperWhiteView.isHidden = false
        }
    }
    func setNormalMode(){
        DispatchQueue.main.async {
            self.stateLabel.text = "나의 현재 주소"
            self.w3w_text.isHidden = false
            self.mainUpperWhiteView.isHidden = true
        }
    }
    func updateMainViewState(){
        updateViewState()
    }
    
}

extension ViewController: GMSMapViewDelegate {
    
}
