//
//  SplashReactor.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/22.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

final class SplashReactor: Reactor {
    
    enum Action {
        
        case viewWillAppear
    }
    
    enum Mutation {
        
        case navigateToCartoon
        case navigateToMain
    }
    
    struct State {
    }
    
    // MARK: Properties
    
    let initialState: State
    let navigator: JGNavigatorProtocol
    
    init(navigator: JGNavigatorProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        
        self.navigator = navigator
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewWillAppear:
            // TODO: 상태값 저장
            return .just(.navigateToCartoon)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .navigateToCartoon:
            
            guard let hasSeenCartoon = DefaultsService.shared.get(.hasSeenCartoon),
                hasSeenCartoon == true else {
                    navigator.navigate(.cartoon(.main))
                    return state
            }
            navigator.navigate(.main(.home))
            
        case .navigateToMain:
            
            break
        }
        return state
    }
}
