//
//  FindLetterReactor.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/28.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

final class FindLetterReactor: Reactor {
    
    // MARK: - Action
    enum Action {
        case cancelBtnClicked
        case findLetterBtnClicked
        
        case receiverPhoneChanged(String)
        case firstWordChanged(String)
        case secondWordChanged(String)
        case thirdWordChanged(String)

    }

    // MARK: - Mutation
    enum Mutation {
        case dismiss
        case focusOnMain
        case findLetterSuccess(FindLetterResponse)
        case error
        
        case receiverPhoneChanged(String)
        case firstWordChanged(String)
        case secondWordChanged(String)
        case thirdWordChanged(String)
    }
    
    // MARK: - State
    struct State {

        /// input
        var receiverPhone: String?
        var firstWord: String?
        var secondWord: String?
        var thirdWord: String?
        
        /// output
        var letterContent: String?
        var latitude: Double?
        var longitude: Double?
        
    }
    
    // MARK: - Properties
    let initialState: State
    private let mainReactor: MainReactor
    private let services: JGServicesProtocol
    private let navigator: JGNavigatorProtocol
    
    init(mainReactor: MainReactor, navigator: JGNavigatorProtocol, services: JGServicesProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.mainReactor = mainReactor
        self.services = services
        self.navigator = navigator
    }
    
    func mutate(action: Action) -> Observable<FindLetterReactor.Mutation> {
        switch action {
        case .cancelBtnClicked:
            return .concat([
                .just(.focusOnMain),
                .just(.dismiss)
            ])
            
        case .findLetterBtnClicked:
            
            guard let request = getFindLetterRequest() else {
                Logger.error("Inavlid Request")
                return .empty()
            }
            return .concat([
                services.apiService
                    .findLetter(request: request)
                    .map(Mutation.findLetterSuccess)
                    .catchErrorJustReturn(.error)
                    .asObservable()
            ])
            
        case .receiverPhoneChanged(let phoneNumber):
            return .just(.receiverPhoneChanged(phoneNumber))
        case .firstWordChanged(let text):
            return .just(.firstWordChanged(text))
        case .secondWordChanged(let text):
            return .just(.secondWordChanged(text))
        case .thirdWordChanged(let text):
            return .just(.thirdWordChanged(text))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
            
        case .focusOnMain:
            mainReactor.action.onNext(.focusOnMain)
            
        case .dismiss:
            navigator.navigate(.findLetter(.dismiss))
            
        case .findLetterSuccess(let response):
            Logger.debug("Find letter response : \(response)")
            
            navigator.navigate(.findLetter(.tracking))
            guard let firstLetter = response.letter.first else {
                    Logger.error("Invalid Letter result")
                    return state
            }
            state.letterContent = firstLetter.message
            state.latitude = Double(firstLetter.latitude)
            state.longitude = Double(firstLetter.longitude)
            
        case .error:
            Logger.error("Find letter error")
            
        case .receiverPhoneChanged(let phoneNumber):
            state.receiverPhone = phoneNumber
            
        case .firstWordChanged(let text):
            state.firstWord = text
            
        case .secondWordChanged(let text):
            state.secondWord = text
            
        case .thirdWordChanged(let text):
            state.thirdWord = text
        }
        return state
    }
    
    private func getFindLetterRequest() -> FindLetterRequest? {
        
        guard let receiverPhone = currentState.receiverPhone, receiverPhone.isNotEmpty,
            let firstWord = currentState.firstWord, firstWord.isNotEmpty,
            let secondWord = currentState.secondWord, firstWord.isNotEmpty,
            let thirdWord = currentState.thirdWord, firstWord.isNotEmpty else {
                Logger.error("Inavlid input")
                return nil
        }
        
        let w3w = firstWord + "." + secondWord + "." + thirdWord

        return FindLetterRequest(receiver_phone: receiverPhone, w3w_address: w3w)
    }
    
}
