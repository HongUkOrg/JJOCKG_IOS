//
//  SMSTraits.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/28.
//  Copyright © 2020 mac. All rights reserved.
//

import MessageUI

protocol SMSTraits {
    func getMessage(_ receiverPhone: String?) -> String?
    func sendSMS(rootView: UIViewController?, _ receiverPhone: String,
                 delegate: MFMessageComposeViewControllerDelegate)
}

extension SMSTraits {
    
    private func checkCanSendSMS()-> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func getMessage(_ receiverPhone: String?) -> String? {
        guard checkCanSendSMS(),
            let receiverPhone = receiverPhone,
            let w3w = W3WStore.shared.w3w.value else {
            Logger.error("Can't send SMS")
            return nil
                // TODO: alert error view
        }
        
        var content = "쪽지가 도착했습니다.\n"
        content += "발신자 : \(receiverPhone)\n"
        content += "주소 : \(w3w)\n"
        content += "from. 쪽쥐 in AppStore"
        
        return content
    }
    
    func sendSMS(rootView: UIViewController?, _ receiverPhone: String, delegate: MFMessageComposeViewControllerDelegate) {
        
        Logger.debug("send sms")
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = delegate
        
        composeVC.recipients = [receiverPhone]
        composeVC.body = getMessage(receiverPhone)
        
        rootView?.presentedViewController?.present(composeVC, animated: true)
    }
}

