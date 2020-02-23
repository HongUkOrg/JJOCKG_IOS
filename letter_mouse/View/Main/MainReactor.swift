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
        case infoBtnClicked
        case locationChanged(LocationModel)
    }
    
    //MARK: Mutation
    enum Mutation {
        case changeW3W(What3WordsResponse)
    }
    
    // MARK: State
    struct State {
        var what3Words: String? = nil
        var location: LocationModel? = nil
    }
    
    // MARK: Properties
    let initialState: State
    let locationModule: LocationModuleProtocol
    private let navigator: JGNavigatorProtocol
    private let services: JGServicesProtocol
    
    // MARK: Initialize
    init(navigator: JGNavigatorProtocol, services: JGServicesProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.navigator = navigator
        self.services = services
        self.locationModule = LocationModule()
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
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .changeW3W(let response):
            Logger.info("reactor response : \(response)")
            state.what3Words = "/// " + response.words
        default:
            break
        }
        return state
    }
}
