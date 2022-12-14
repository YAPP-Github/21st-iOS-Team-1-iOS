//
//  SignUpNickNameViewModel.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/29.
//

import Foundation

import FindTownCore
import FindTownUI
import RxSwift
import RxRelay

protocol SignUpNickNameViewModelType {
    func goToFirstInfo()
}

enum SignUpNickNameStatus {
    case none
    case complete
    case duplicate
    case inSpecialChar
}

final class NicknameViewModel: BaseViewModel {
    
    struct Input {
        let nickname = PublishSubject<String>()
        let nickNameCheckTrigger = PublishSubject<String>()
        let nextButtonTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let nickNameStatus = PublishRelay<SignUpNickNameStatus>()
        let buttonsSelected = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    let delegate: SignUpCoordinatorDelegate
    
    init(delegate: SignUpCoordinatorDelegate) {
        self.delegate = delegate
        super.init()
        self.bind()
    }
    
    func bind() {
        
        self.input.nickname
            .bind { [weak self] _ in
                self?.output.buttonsSelected.accept(true)
            }
            .disposed(by: disposeBag)
        
        self.input.nickNameCheckTrigger
            .bind { [weak self] nickName in
                // 특수문자 없으면 + 공백이 아니면 닉네임 체크
                if nickName.isValidNickname() {
                    
                    // 닉네임 중복 체크 들어갈 자리
                    self?.output.nickNameStatus.accept(.complete)
                    
                } else {
                    self?.output.nickNameStatus.accept(.inSpecialChar)
                }
            }
            .disposed(by: disposeBag)
        
        self.input.nextButtonTrigger
            .withLatestFrom(self.input.nickname)
            .bind(onNext: self.setNickname(nickname:))
            .disposed(by: disposeBag)
    }
    
    private func setNickname(nickname: String) {
        // 1. nickname 임시로 set (내부디비?)
        print("setNickname \(nickname)")
        
        // after
        self.goToFirstInfo()   
    }
}

extension NicknameViewModel: SignUpNickNameViewModelType {
    func goToFirstInfo() {
        delegate.goToFirstInfo()
    }
}
