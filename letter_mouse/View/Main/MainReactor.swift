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
    }
    
    //MARK: Mutation
    enum Mutation {
    }
    
    // MARK: State
    struct State {
    }
    
    // MARK: Properties
    let initialState: State
    let navigator: JGNavigatorProtocol
    
    // MARK: Initialize
    init(navigator: JGNavigatorProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.navigator = navigator
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .infoBtnClicked:
            break
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
