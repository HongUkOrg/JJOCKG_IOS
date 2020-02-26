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
    }
    
    // MARK: - Mutation
    enum Mutation {
    }
    
    // MARK: - State
    struct State {
    }

    // MARK: - Properties
    let initialState: State
    private let navigator: JGNavigatorProtocol
    private let services: JGServicesProtocol
    
    init(navigator: JGNavigatorProtocol, services: JGServicesProtocol) {
        defer { _ = self.state }
        self.initialState = State()
        self.navigator = navigator
        self.services = services
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .sendLetterBtnClicked:
            break
        case .dismissBtnClicked:
            navigator.navigate(.sendLetter(.dismiss))
        default:
            break
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
