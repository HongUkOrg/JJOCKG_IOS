//
//  SendLetterMainVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/26.
//  Copyright © 2020 mac. All rights reserved.
//
import ReactorKit
import RxSwift
import RxCocoa
import Then
import SnapKit

final class SendLetterMainVC: BaseViewController, View {
    typealias Reactor = SendLetterReactor
    
    // MARK: - Initialize
    init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
        view.backgroundColor = .clear
    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {
    }
}
