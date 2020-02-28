//
//  MainReactor.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

final class MainReactor: Reactor {
    
    // MARK: Action
    enum Action {
        
        case locationChanged(LocationModel)
        case checkLoacationPermission
        case fetchLocation(Bool)
        
        case focusOnMain
        
        case infoBtnClicked
        case sendLetterBtnClicked
        case findLetterBtnClicked
    }
    
    //MARK: Mutation
    enum Mutation {
        case changeW3W(What3WordsResponse)
        case fetchLocation(Bool)
        case setLocation(LocationModel)
        case changeLetterStep(LetterStep)
        
        case presentSendLetterView
        case presentFindLetterView
    }
    
    // MARK: State
    struct State {
        var what3Words: String? = nil
        var isFetchLocation: Bool = false
        var letterStep: LetterStep = .normal
        
    }
    
    // MARK: Properties
    let initialState: State
    let locationModule: LocationModuleProtocol
    private let navigator: JGNavigatorProtocol
    private let services: JGServicesProtocol
    private let w3wStore: W3WStore
    
    // MARK: Initialize
    init(navigator: JGNavigatorProtocol, services: JGServicesProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.navigator = navigator
        self.services = services
        self.locationModule = LocationModule()
        self.w3wStore = W3WStore.shared
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .infoBtnClicked:
            break
        case .locationChanged(let locationModel):
            return .concat([
                services.apiService
                    .getW3W(location: locationModel)
                    .map(Mutation.changeW3W)
                    .asObservable(),
                .just(.setLocation(locationModel))
            ])
            
        case .sendLetterBtnClicked:
            return .concat([
                .just(.fetchLocation(false)),
                .just(.changeLetterStep(.send)),
                .just(.presentSendLetterView)
            ])
        case .findLetterBtnClicked:
            return .concat([
                .just(.changeLetterStep(.send)),
                .just(.presentFindLetterView)
            ])
            
        case .checkLoacationPermission:
            // TODO: - location permission check
            return .just(.fetchLocation(true))
            
        case .fetchLocation(let value):
            return .just(.fetchLocation(value))
            
        case .focusOnMain:
            return .concat([
                .just(.fetchLocation(true)),
                .just(.changeLetterStep(.normal))
            ])
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .changeW3W(let response):
            state.what3Words = "/// " + response.words
            w3wStore.w3w.accept(response.words)
            
        case .presentSendLetterView:
            navigator.navigate(.sendLetter(.main))
        case .presentFindLetterView:
            navigator.navigate(.findLetter(.main))
            
        case .fetchLocation(let value):
            state.isFetchLocation = value
            
        case .changeLetterStep(let step):
            state.letterStep = step
            
        case .setLocation(let locationModel):
            w3wStore.locationModel.accept(locationModel)
        }
        return state
    }
}
