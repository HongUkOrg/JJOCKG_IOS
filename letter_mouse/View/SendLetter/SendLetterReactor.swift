//
//  SendLetterReactor.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/26.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

final class SendLetterReactor: Reactor {
    
    // MARK: - Action
    enum Action {
        case sendLetterBtnClicked
        case dismissBtnClicked
        
        case letterContentCahnged(String)
        case receiverPhoneChanged(String)
        
        case smsSendBtnClicked
    }
    
    // MARK: - Mutation
    enum Mutation {
        
        case setLetterContent(String)
        case setReceiverPhoneNumber(String)
        case navigateToResult(String)
        case navigateToSMS
        case error(SendLetterError)
    }
    
    // MARK: - State
    struct State {
        var receiverPhone: String?
        var letterText: String?
    }

    // MARK: - Properties
    let initialState: State
    private let navigator: JGNavigatorProtocol
    private let services: JGServicesProtocol
    private let mainReactor: MainReactor
    
    init(mainReactor: MainReactor, navigator: JGNavigatorProtocol, services: JGServicesProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.navigator = navigator
        self.services = services
        self.mainReactor = mainReactor
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .sendLetterBtnClicked:
            guard currentState.receiverPhone?.isNotEmpty ?? false else {
                return .just(.error(.emptyPassword))
            }
            guard currentState.letterText?.isNotEmpty ?? false else {
                return .just(.error(.emptyContent))
            }
            guard let request = getSendLetterRequest() else {
                return .just(.error(.invalidRequestInput))
            }
            
            return .concat([
                services.apiService
                    .sendLetter(request: request)
                    .map(Mutation.navigateToResult)
                    .asObservable()
            ])
        case .dismissBtnClicked:
            mainReactor.action.onNext(.focusOnMain)
            navigator.navigate(.sendLetter(.dismiss))
            
        case .letterContentCahnged(let text):
            return .just(.setLetterContent(text))
        case .receiverPhoneChanged(let phoneNumber):
            return .just(.setReceiverPhoneNumber(phoneNumber))
        case .smsSendBtnClicked:
            return .just(.navigateToSMS)
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setLetterContent(let text):
            state.letterText = text
        case .setReceiverPhoneNumber(let phoneNumber):
            state.receiverPhone = phoneNumber
        case .navigateToResult(let response):
            Logger.debug("sendLetterResult : \(response)")
            navigator.navigate(.sendLetter(.result))
        case .error(let error):
            navigator.navigate(.etc(.alert(.sendLetter(error))))
            Logger.error("Invalid SendLetter Request")
        case .navigateToSMS:
            navigator.navigate(.etc(.sms(currentState.receiverPhone)))
        }
        return state
    }
    
    private func getSendLetterRequest() -> SendLetterRequest? {
        
        guard let receiverPhone = currentState.receiverPhone, receiverPhone != "",
            let message = currentState.letterText, message != "",
            let w3w = W3WStore.shared.w3w.value,
            let latitude = W3WStore.shared.locationModel.value?.latitude,
            let longitude = W3WStore.shared.locationModel.value?.longitude else {
                Logger.error("SendLetterRequest: Invalid input!")
                return nil
        }

        return SendLetterRequest(receiver_phone: receiverPhone,
                                 message: message.removeSwiftLineBreak(),
                                 w3w_address: w3w,
                                 latitude: latitude,
                                 longitude: longitude)
    }
    
}
