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
        case pageChanged(Int)
        case skipBtnClicked
    }
    
    // MARK: Mutation
    enum Mutation {
        case pageChanged(Int)
        case navigaToMain
    }
    
    // MARK: State
    struct State {
        
        var currentPage: Int = 1
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
        switch action {
        case .pageChanged(let page):
            return .just(.pageChanged(page))
        case .skipBtnClicked:
            return .just(.navigaToMain)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .pageChanged(let page):
            Logger.debug("page changed \(page)")
            state.currentPage = page
        case .navigaToMain:
            navigator.navigate(.main(.home))
        }
        return state
    }
}
