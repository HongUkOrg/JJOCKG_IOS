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
        
        case letterOpenToggle
        case checkDistance
        
    }

    // MARK: - Mutation
    enum Mutation {
        case dismiss
        case focusOnMain
        case findLetterSuccess(FindLetterResponse)
        case error(FindLetterError)
        
        case receiverPhoneChanged(String)
        case firstWordChanged(String)
        case secondWordChanged(String)
        case thirdWordChanged(String)
        
        case letterOpenToggle
        case checkDistance(Int?)
        
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
        
        /// tracking
        var canRead: Bool = false
        var letterOpend: Bool = false
        
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
            
            guard currentState.firstWord?.isNotEmpty ?? false,
                currentState.secondWord?.isNotEmpty ?? false,
                currentState.secondWord?.isNotEmpty ?? false else {
                    return .just(.error(.emptyW3W))
            }
            
            guard currentState.receiverPhone?.isNotEmpty ?? false else {
                return .just(.error(.emptyPassword))
            }
            
            guard let request = getFindLetterRequest() else {
                return .just(.error(.invalidInput))
            }
            
            return .concat([
                services.apiService
                    .findLetter(request: request)
                    .map(Mutation.findLetterSuccess)
                    .catchErrorJustReturn(.error(.findFail))
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
            
        case .letterOpenToggle:
            return .just(.letterOpenToggle)
            
        case .checkDistance:
            return .just(.checkDistance(services.letterService.distance))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
            
        case .focusOnMain:
            mainReactor.action.onNext(.focusOnMain)
            
        case .dismiss:
            Logger.debug("tracking dismiss")
            services.letterService.reset()
            navigator.navigate(.findLetter(.dismiss))
            
        case .findLetterSuccess(let response):
            Logger.debug("Find letter response : \(response)")
            
            guard let firstLetter = response.letter.first,
                let latitude = Double(firstLetter.latitude),
                let longitude = Double(firstLetter.longitude) else {
                    Logger.error("Invalid Letter result")
                    return state
            }
            mainReactor.action.onNext(.changeLetterStep(.tracking))
            navigator.navigate(.findLetter(.tracking))
            state.letterContent = firstLetter.message
            
            let locationModel = LocationModel(latitude: latitude, longitude: longitude)
            services.letterService.letterLocation.accept(locationModel)
            
        case .error(let error):
            navigator.navigate(.etc(.alert(.findLetter(error))))
            
        case .receiverPhoneChanged(let phoneNumber):
            state.receiverPhone = phoneNumber
            
        case .firstWordChanged(let text):
            state.firstWord = text
            
        case .secondWordChanged(let text):
            state.secondWord = text
            
        case .thirdWordChanged(let text):
            state.thirdWord = text
            
        case .letterOpenToggle:
            state.letterOpend = !state.letterOpend // toggle
            
        case .checkDistance(let distance):
            guard let distance = distance else { return state }
            state.canRead = distance <= 50
            
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
