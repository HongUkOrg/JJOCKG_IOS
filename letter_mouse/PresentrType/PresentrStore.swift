//
//  PresentrStore.swift
//  letter_mouse
//
//  Created by David Park on 17/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Presentr

class PresentrStore: NSObject {

    static let uiViewHeight = UIScreen.main.bounds.height
    static let uiViewWidth  = UIScreen.main.bounds.width
    
    static let getInstance : PresentrStore = PresentrStore()
    
    let simplePresentR : Presentr = {
        let width = ModalSize.custom(size: Float(uiViewWidth*0.9))
        let height = ModalSize.custom(size:Float(uiViewHeight*0.75))
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
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.backgroundOpacity = 0
        customPresenter.backgroundTap = .noAction
        customPresenter.keyboardTranslationType = .stickToTop
        
        
        return customPresenter
        
    }()
    let findPresentR : Presentr = {
        let width = ModalSize.custom(size: Float(uiViewWidth*0.9))
        let height = ModalSize.custom(size: 350.0)
        let center = ModalCenterPosition.custom(
            centerPoint: CGPoint.init(
                x: UIScreen.main.bounds.width*0.5,
                y: UIScreen.main.bounds.height - 175.0
        ))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .coverVertical
        customPresenter.dismissAnimated = true
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.backgroundOpacity = 0
        customPresenter.keyboardTranslationType = .moveUp
        
        
        return customPresenter
        
    }()
    let letterResultpresentR : Presentr = {
        let width = ModalSize.custom(size: Float(uiViewWidth*0.95))
        let height = ModalSize.custom(size:Float(uiViewHeight*0.8))
        let center = ModalCenterPosition.custom(
            centerPoint: CGPoint.init(
                x: uiViewWidth*0.5,
                y: uiViewHeight*(0.60)
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
}
