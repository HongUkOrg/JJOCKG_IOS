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
        
        case infoBtnClicked
        case sendLetterBtnClicked
        case findLetterBtnClicked
    }
    
    //MARK: Mutation
    enum Mutation {
        case changeW3W(What3WordsResponse)
        case fetchLocation(Bool)
        
        case presentSendLetterView
        case presentFindLetterView
    }
    
    // MARK: State
    struct State {
        var what3Words: String? = nil
        var location: LocationModel? = nil
        var isFetchLocation: Bool = false
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
        self.w3wStore = W3WStore.sharedInstance
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .infoBtnClicked:
            break
        case .locationChanged(let locationModel):
            return services.apiService
                .getW3W(location: locationModel)
                .map(Mutation.changeW3W)
                .asObservable()
            
        case .sendLetterBtnClicked:
            return .concat([
                .just(.fetchLocation(false)),
                .just(.presentSendLetterView)
            ])
        case .findLetterBtnClicked:
            return .just(.presentFindLetterView)
            
        case .checkLoacationPermission:
            // TODO: - location permission check
            return .just(.fetchLocation(true))
            
        case .fetchLocation(let value):
            return .just(.fetchLocation(value))
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
        }
        return state
    }
}
