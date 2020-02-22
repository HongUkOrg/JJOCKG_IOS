//
//  CartoonReactor.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//



import Foundation
import RxSwift
import ReactorKit

final class CartoonReactor: Reactor {
    
    // MARK: Action
    enum Action {
    }
    
    // MARK: Mutation
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
    
    // MARK: Methods
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
