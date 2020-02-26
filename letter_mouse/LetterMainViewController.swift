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

enum ViewState {
    case SENDING_LETTER, TRACKING_LETTER, NORMAL
}


class LetterMainViewController: UIViewController, CLLocationManagerDelegate {
    

    
    let locationManager = CLLocationManager()
    var currentLatitude : Double?
    var currentLongitude : Double?
    private var nextUpdateCount : Int = 0
    private var zoomedNow : Bool = false
    
    @IBOutlet fileprivate weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var w3w_text_view: UIView!
    @IBOutlet weak var w3w_first_word: UILabel!
    @IBOutlet weak var w3w_second_word: UILabel!
    @IBOutlet weak var w3w_third_word: UILabel!
    
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
        mainUpperYellowView.frame = CGRect(x : 0,y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.10 )
        
        self.hideKeyboardWhenTappedAround()
        
        print("Main View Acitivity View Did Load!!!")
        _ = getViewState()
        
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
        googleMapView.isMyLocationEnabled = true
        
        w3w_text_view.layer.cornerRadius = 18
        w3w_text_view.clipsToBounds = true
        
    }
    
    func didReceiveDismiss_save() {
        print("MainViewController : called save didReceiveDismiss func")
        
        _ = getViewState()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
            self.showSMSView()
        }
        
    }
    func didReceiveDismiss_find(_ success : Bool) {
        print("MainViewController : called find didReceiveDismiss func")
        
        _ = getViewState()
        if success{
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
                self.showLetterResultView()
            }
        }
        else {
            print("ERROR :: find fail!!!!!!!")
        }
        
    }
    func didReceiveDismiss_sms() {
        _ = getViewState()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
            self.showSmsFindView()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        updateViewState()
        if getViewState() == ViewState.SENDING_LETTER {
            return
        }
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        if nextUpdateCount >= 5 || nextUpdateCount == 0 {
            
            googleMapView.clear()
            
//            let marker = GMSMarker()
//
//            marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
//            marker.title = "CurrentPosition"
//            marker.snippet = "Letter"
//            marker.icon = UIImage(named: "current_letter")
//            marker.map = googleMapView

            
            let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 18.0)
            googleMapView.camera = camera
            
            currentLatitude = locValue.latitude
            currentLongitude = locValue.longitude
            LetterController.getInstance.latitude = currentLatitude!
            LetterController.getInstance.longitude = currentLongitude!
            
            nextUpdateCount = 1
        }
        else {
            nextUpdateCount += 1
        }
        
       
        
        if let isTrackingNow = LetterController.getInstance.isTrackingLetterNow, isTrackingNow {
            setLetterTrackingMode()
            
            DispatchQueue.main.async {
                let calculatedDistance = self.calculateDistance()
                let distanceMsg = "쪽지까지 앞으로\n"+String(Int(calculatedDistance)) + " 미터!"
                
                self.distanceLabel.text = distanceMsg
                if self.canOpenLetter(calculatedDistance)  {
                    self.callBackLetterTrackingView(true)
                }
                else {
                    self.callBackLetterTrackingView(false)
                }
                
                if !self.zoomedNow {
                    let zoomLevel = self.getZoomLevel(calculatedDistance)
                    let middleLati : Double = (LetterController.getInstance.latitude + LetterController.getInstance.findedLetterLati!)/2.0
                    let middleLong : Double = (LetterController.getInstance.longitude + LetterController.getInstance.findedLetterLong!)/2.0
                    let camera = GMSCameraPosition.camera(withLatitude: middleLati, longitude: middleLong, zoom: zoomLevel)
                    self.googleMapView.camera = camera
                }
                self.zoomedNow = true
            }
            
        }
        else {
            setNormalMode()
        }
    }
    func setSavedLetterMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: LetterController.getInstance.findedLetterLati!, longitude: LetterController.getInstance.findedLetterLong!)
        marker.title = "under seal Letter"
        marker.snippet = "Letter"
        marker.icon = UIImage(named: "current_letter")
        marker.map = googleMapView
        
        let path = GMSMutablePath()
        path.addLatitude(LetterController.getInstance.latitude, longitude: LetterController.getInstance.longitude)
        path.addLatitude(LetterController.getInstance.findedLetterLati!, longitude: LetterController.getInstance.findedLetterLong!)
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.strokeColor = UIColor.init(red: 0.2274, green: 0.1960, blue: 0.035, alpha: 1)
        polyline.geodesic = true
        polyline.map = googleMapView
        
        
    }
    func getZoomLevel(_ calculatedDistance : Double) -> Float {
        var level : Float = 11.0
        var distance = 8000.0
        
        if calculatedDistance > distance {
            while calculatedDistance > distance {
                distance *= 2
                level -= 1
                if level == 1 {
                    break
                }
            }
        }
        else {
            while calculatedDistance < distance {
                distance /= 2
                level += 1
                if level == 18 {
                    break
                }
            }
        }
        print("get zoom level \(calculatedDistance), \(level)")

        return level
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
        _ = self.storyboard?.instantiateViewController(withIdentifier: "SaveLetterViewController") as! SaveLetterViewController

    }
    
    @IBAction func letterFindBtn(_ sender: UIButton) {
        
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "findLetterViewController") as! FindLetterViewController
//        customPresentViewController(PresentrStore.getInstance.findPresentR , viewController:controller, animated: true,completion: {
//            print("complete")
//        })
    }
    func showSmsFindView() {
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SMSFindLetterViewController") as! SMSFindViewController
//        customPresentViewController(PresentrStore.getInstance.smsFindPresentR , viewController:controller, animated: true,completion: {
//            self.stateLabel.text = "SMS로 찾기"
//            print("complete")
//        })
    }
    func showSMSView(){
        
//         let controller = self.storyboard?.instantiateViewController(withIdentifier: "SMSSendViewController") as! SMSViewController
//        customPresentViewController(PresentrStore.getInstance.simplePresentR , viewController:controller, animated: true,completion: {
//            self.stateLabel.text = "SMS로 보내기"
//            print("complete")
//        })
    }
    func showLetterResultView(){
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LetterResultViewController") as! LetterResultViewController
//        customPresentViewController(PresentrStore.getInstance.letterResultpresentR , viewController:controller, animated: true,completion: {
//            print("complete")
//        })
    }
    
    func showSaveLetterView(view: UIView, hidden: Bool) {
        
        UIView.transition(with: view, duration: 1, options: .transitionFlipFromBottom ,animations: {
            view.isHidden = hidden
        })
    }
    func animateW3WTextView(offset : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState],
                       animations: {
                        self.w3w_text_view.frame.origin.y += UIScreen.main.bounds.height * offset
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    public func setDismissDelegate(delegate : ModalDimissDelegate_save ) {
        self.dismissDelegate = delegate
    }
    
    func processResult(_ result: String) {
        let words = result.split(separator: ".")
        if !LetterController.getInstance.isSending {
            LetterController.getInstance.currentWhat3Words = result
            w3w_first_word.text = "\(words[0])"
            w3w_second_word.text = "\(words[1])"
            w3w_third_word.text = "\(words[2])"
            print(result)
        }
    }
    
    func canOpenLetter(_ distance : Double) -> Bool {
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
    
    func getViewState() -> ViewState {
        if let isTrakcing = LetterController.getInstance.isTrackingLetterNow, isTrakcing {
            return ViewState.TRACKING_LETTER
        }
        else if LetterController.getInstance.isSending {
            return ViewState.SENDING_LETTER
        }
        else {
            return ViewState.NORMAL
        }
    }
    func updateViewState() {
        switch getViewState() {
        case .SENDING_LETTER :
            setLetterSendingMode()
        case .TRACKING_LETTER :
            setLetterTrackingMode()
        case .NORMAL :
            setNormalMode()
        }
    }
    func setLetterSendingMode() {
        DispatchQueue.main.async {
            if !LetterController.getInstance.isSending{
                self.stateLabel.text = "쪽지 남기기"
                
            }
            self.w3w_text_view.isHidden = false
            self.mainUpperWhiteView.isHidden = true
        }
    }
    func setLetterTrackingMode(){
        DispatchQueue.main.async {
            if !LetterController.getInstance.isSending{
                self.stateLabel.text = "쪽지 찾기"
            }
            self.setSavedLetterMarker()
            self.w3w_text_view.isHidden = true
            self.mainUpperWhiteView.isHidden = false
        }
    }
    func setNormalMode(){
        DispatchQueue.main.async {
            self.googleMapView.clear()
            self.stateLabel.text = "나의 현재 주소"
            self.w3w_text_view.isHidden = false
            self.mainUpperWhiteView.isHidden = true
            LetterController.getInstance.isSending = false
            self.zoomedNow = false
        }
    }
    func updateMainViewState(){
        updateViewState()
    }
    
}

extension SplashVC: GMSMapViewDelegate {
    
}
