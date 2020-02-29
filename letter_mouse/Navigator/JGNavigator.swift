//
//  JGNavigator.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/22.
//  Copyright © 2020 mac. All rights reserved.
//
import Foundation
import UIKit
import MessageUI

// MARK: Navigation Step
enum JGNavigateStep {
    
    case splash(SplashStep)
    case cartoon(CartoonStep)
    case main(MainStep)
    
    case sendLetter(SendLetterStep)
    case findLetter(FindLetterStep)
    
    case etc(EtcStep)
    
}

extension JGNavigateStep {
    
    enum SplashStep {
        case locationPermission
    }
    
    enum CartoonStep {
        case main
        case one
        case two
        case three
    }
    
    enum MainStep {
        case home
    }
    
    enum SendLetterStep {
        case main
        case result
        case dismiss
    }
    
    enum FindLetterStep {
        case main
        case tracking
        case dismiss
    }
    
    enum EtcStep {
        case sms(String?)
    }
    
}

protocol JGNavigatorProtocol {
    
    // MARK: Properties
    var window: UIWindow? { get }
    var rootViewController: UIViewController? { get set }
    
    // MARK: Methods
    func navigate(_ step: JGNavigateStep)
}

class JGNavigator: NSObject, JGNavigatorProtocol, SMSTraits {
    
    // MARK: Properties
    var window: UIWindow?
    var rootViewController: UIViewController? {
        get {
            return window?.rootViewController
        }
        set { }
    }
    
    private let services: JGServicesProtocol
    private var mainReactor: MainReactor?
    private var sendLetterReactor: SendLetterReactor?
    private var findLetterReactor: FindLetterReactor?
    
    // MARK: Initialize
    init(_ window: UIWindow?) {
        self.window = window
        self.services = JGServices()
    }
    
    // MARK: Navigate
    func navigate(_ step: JGNavigateStep) {

        // MARK: Navigation - Splash <-> Main
        switch step {
            
        case .splash(let destination):

            Logger.info("Navigate to Splash - \(destination)")

            switch destination {
            case .locationPermission:
                break
                
            }

        case .cartoon(let destination):
            
            Logger.info("Navigate to Cartoon - \(destination)")
            
            switch destination {
            case .main:
                
                let cartoonReactor = CartoonReactor(navigator: self)
                let cartoonMainVC = CartoonMainVC(reactor: cartoonReactor)
                cartoonMainVC.modalPresentationStyle = .fullScreen
                
                self.rootViewController?.present(cartoonMainVC, animated: true)
            case .one:
                break
            case .two:
                break
            case .three:
                break
            }
            
        case .main(let destination):
            
            Logger.info("Navigate to Main - \(destination)")
            switch destination {
            case .home:
                mainReactor = MainReactor(navigator: self, services: services)
                
                guard let mainReactor = mainReactor else { return }
                
                let mainVC = MainVC(reactor: mainReactor)
                self.window?.rootViewController = mainVC
                
                UIView.transition(with: window!,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {},
                                  completion: nil)
            }
            
        case .sendLetter(let destination):
            
            Logger.info("Navigate to sendLetter - \(destination)")
            
            guard let mainReactor = mainReactor else { return }
            
            switch destination {
            case .main:
                sendLetterReactor = SendLetterReactor(mainReactor: mainReactor, navigator: self, services: services)
                guard let sendLetterReactor = sendLetterReactor else { return }
                let sendLetterMainVC = SendLetterMainVC(reactor: sendLetterReactor)
                let navigationVC = UINavigationController(rootViewController: sendLetterMainVC)
                
                navigationVC.isNavigationBarHidden = true
                navigationVC.modalPresentationStyle = .overFullScreen
                
                rootViewController?.present(navigationVC, animated: true)
                
            case .result:
                
                guard let navigationVC = rootViewController?.presentedViewController as? UINavigationController,
                let sendLetterReactor = sendLetterReactor else {
                    Logger.error("Inavlid View stack")
                    return
                }
                
                let sendLetterResultVC = SendLetterResultVC(reactor: sendLetterReactor)
                navigationVC.pushViewController(sendLetterResultVC, animated: true)
                                
            case .dismiss:
                rootViewController?.presentedViewController?.dismiss(animated: true)
            }
            
        case .findLetter(let destination):
            
            Logger.info("Navigate to findLetter - \(destination)")
            guard let mainReactor = mainReactor else { return }
            
            switch destination {
            case .main:
                
                
                findLetterReactor = FindLetterReactor(mainReactor: mainReactor, navigator: self, services: services)
                
                guard let findLetterReactor = findLetterReactor else { return }
                
                let findLetterMainVC = FindLetterMainVC(reactor: findLetterReactor)
                let navigationVC = UINavigationController(rootViewController: findLetterMainVC)
                navigationVC.isNavigationBarHidden = true
                navigationVC.modalPresentationStyle = .overCurrentContext
                
                rootViewController?.present(navigationVC, animated: true)
                
            case .tracking:
                
                guard let findLetterReactor = findLetterReactor,
                    let navigationVC = rootViewController?.presentedViewController as? UINavigationController else { return }
                
                let findLetterTrackingVC = FindLetterTrackingVC(reactor: findLetterReactor)
                navigationVC.pushViewController(findLetterTrackingVC, animated: true)

            case .dismiss:
                rootViewController?.presentedViewController?.dismiss(animated: true)
                
            }
            
        case .etc(let destination):
            switch destination {
            case .sms(let receiver):
                
                // TODO: make as Traits
                guard let receiver = receiver else {
                    Logger.error("Inavlid Receiver phone number")
                    return
                }
                
                sendSMS(rootView: rootViewController, receiver, delegate: self)
                
            }
        /// end switch
        }
    }
    
}

extension JGNavigator: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}
