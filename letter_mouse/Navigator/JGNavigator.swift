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
    
}

extension JGNavigateStep {
    
    enum SplashStep {
        case locationPermission
    }
    
    enum CartoonStep {
        case one
        case two
        case three
    }
    
}

protocol JGNavigatorProtocol {
    
    // MARK: Properties
    var rootViewController: UIViewController? { get set }
    
    // MARK: Methods
    func navigate(_ step: JGNavigateStep)
}

class JGNavigator: JGNavigatorProtocol {
    
    // MARK: Properties
    var rootViewController: UIViewController?
    
    // MARK: Initialize
    init(_ rootView: UIViewController?) {
        rootViewController = rootView
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
            case .one:
                break
            case .two:
                break
            case .three:
                break
            }
            
        /// end switch
        }
    }
    
}
