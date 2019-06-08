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




class LetterMainViewController: UIViewController, CLLocationManagerDelegate, ModalDimissDelegate {
   
    
    func didReceiveDismiss() {
        print("MainViewController : called didReceiveDismiss func")
        
        // Runs after 1 second on the main queue.
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ) {
            self.showSMSView()
        }
        
    }
    

    
    static let getInstance : LetterMainViewController = LetterMainViewController()
    public var dismissDelegate : ModalDimissDelegate?
    
    let presenter : Presentr = {
        let width = ModalSize.custom(size: Float(UIScreen.main.bounds.width*0.9))
        let height = ModalSize.custom(size:Float(UIScreen.main.bounds.height*0.75))
        let center = ModalCenterPosition.custom(
            centerPoint: CGPoint.init(
                x: UIScreen.main.bounds.width*0.5,
                y: UIScreen.main.bounds.height*(0.625)
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
    let findPresenter : Presentr = {
        let width = ModalSize.custom(size: Float(UIScreen.main.bounds.width*0.9))
        let height = ModalSize.custom(size:Float(UIScreen.main.bounds.height*0.4))
        let center = ModalCenterPosition.custom(
            centerPoint: CGPoint.init(
                x: UIScreen.main.bounds.width*0.5,
                y: UIScreen.main.bounds.height*(0.5)
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
    let locationManager = CLLocationManager()
    var currentLatitude : Double?
    var currentLongitude : Double?
    @IBOutlet fileprivate weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var w3w_text: UITextField!
    @IBOutlet weak var sendLetterBtn: UIButton!
    @IBOutlet weak var sendLetterCancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        LetterController.getInstace.setLetterSaveDismissDelegate(delegate: self)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        googleMapView.clear()
        let marker = GMSMarker()
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 18.0)
        
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "CurrentPosition"
        marker.snippet = "Letter"
        marker.icon = UIImage(named: "map_letter")
        
        googleMapView.camera = camera
        marker.map = googleMapView
        
        currentLatitude = locValue.latitude
        currentLongitude = locValue.longitude
        HttpConnectionHandler.getInstance.getWhat3WordsFromGPS(
            latitude: String(format:"%f",currentLatitude!),
            longitude: String(format:"%f",currentLongitude!)
        )
        LetterController.getInstace.latitude = String(format:"%f",currentLatitude!)
        LetterController.getInstace.longitude = String(format:"%f",currentLongitude!)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let w3w = LetterController.getInstace.what3Words
        if !w3w.isEmpty{
            var words = w3w.characters.split(separator: ".")
            w3w_text.text = "\(words[0]) \t / \t \(words[1]) \t / \t\(words[2])"
            print(w3w)
        }
        
    
    }

    @IBAction func letterSaveBtn(_ sender: UIButton) {
        
        
//        showSaveLetterView(view: saveLetterView, hidden: false)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SaveLetterViewController") as! SaveLetterViewController
//        saveLetterView.isHidden = false
//        presenter.customBackgroundView = saveLetterView
//        animateW3WTextView(offset: 0.08)
        // dismiss를 감지할 수 없으니까.. 굳이 이걸 할 필요가 있나 싶음
        
        customPresentViewController(presenter , viewController:controller, animated: true,completion: {
            print("complete")
        })
        
    
    }
    
    @IBAction func letterFindBtn(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "findLetterViewController") as! FindLetterViewController
        customPresentViewController(findPresenter , viewController:controller, animated: true,completion: {
            print("complete")
        })
    }
    func showSMSView(){
         let controller = self.storyboard?.instantiateViewController(withIdentifier: "SMSSendViewController") as! SMSViewController
        customPresentViewController(presenter , viewController:controller, animated: true,completion: {
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
    
    public func setDismissDelegate(delegate : ModalDimissDelegate ){
        self.dismissDelegate = delegate
    }
    
}

extension ViewController: GMSMapViewDelegate {
    
}
