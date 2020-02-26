//
//  JGNavigator.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/22.
//  Copyright © 2020 mac. All rights reserved.
//
import Foundation
import UIKit
import ReplayKit

// MARK: Navigation Step
enum JGNavigateStep {
    
    case splash(SplashStep)
    case cartoon(CartoonStep)
    case main(MainStep)
    
    case sendLetter(SendLetterStep)
    case findLetter(FindLetterStep)
    
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
    }
    
    enum FindLetterStep {
        case main
    }
    
}

protocol JGNavigatorProtocol {
    
    // MARK: Properties
    var window: UIWindow? { get }
    var rootViewController: UIViewController? { get set }
    
    // MARK: Methods
    func navigate(_ step: JGNavigateStep)
}

class JGNavigator: JGNavigatorProtocol {
    
    // MARK: Properties
    var window: UIWindow?
    var rootViewController: UIViewController? {
        get {
            return window?.rootViewController
        }
        set { }
    }
    
    private let services: JGServicesProtocol
    
    // MARK: Initialize
    init(_ window: UIWindow?) {
        self.window = window
        services = JGServices()
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
                let mainReactor = MainReactor(navigator: self, services: services)
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
            switch destination {
            case .main:
                break
            default:
                break
            }
            
        case .findLetter(let destination):
            
            Logger.info("Navigate to findLetter - \(destination)")
            switch destination {
            case .main:
                break
            default:
                break
            }
            
        /// end switch
        }
    }
    
}
