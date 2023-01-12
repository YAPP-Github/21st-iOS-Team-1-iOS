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

protocol NicknameViewModelType {
    func goToLocationAndYears(_ signupUserModel: SignupUserModel)
}

// 수정
struct SignupUserModel {
    var nickname: String
    var dongYearMonth: DongYearMonth
    var jachiguDong: JachiguDong
    var townLikeText: String
    
    init(nickname: String = "", dongYearMonth: DongYearMonth = .init(),
         jachiguDong: JachiguDong = .init(), townLikeText: String = ""
    ) {
        self.nickname = nickname
        self.dongYearMonth = dongYearMonth
        self.jachiguDong = jachiguDong
        self.townLikeText = townLikeText
    }
}

enum NicknameStatus {
    case none
    case complete
    case duplicate
    case includeSpecialChar
}

final class NicknameViewModel: BaseViewModel {
   
    struct Input {
        let nickname = PublishSubject<String>()
        let nickNameCheckTrigger = PublishSubject<String>()
        let nextButtonTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let nickNameStatus = PublishRelay<NicknameStatus>()
    }
    
    let input = Input()
    let output = Output()
    let delegate: SignupViewModelDelegate
    
    init(
        delegate: SignupViewModelDelegate
    ) {
        self.delegate = delegate
        
        super.init()
        self.bind()
    }
    
    func bind() {
        
        self.input.nickname
            .bind { [weak self] _ in
                self?.output.nickNameStatus.accept(.none)
            }
            .disposed(by: disposeBag)
        
        self.input.nickNameCheckTrigger
            .bind { [weak self] nickName in
                // 특수문자 없으면 + 공백이 아니면 닉네임 체크
                if nickName.isValidNickname() {
                    
                    // 닉네임 중복 체크 들어갈 자리
                    self?.output.nickNameStatus.accept(.complete)
                    
                } else {
                    self?.output.nickNameStatus.accept(.includeSpecialChar)
                }
            }
            .disposed(by: disposeBag)
        
        self.input.nextButtonTrigger
            .withLatestFrom(self.input.nickname)
            .bind(onNext: self.setNickname(nickname:))
            .disposed(by: disposeBag)
    }
    
    private func setNickname(nickname: String) {
        // 1. nickname 임시로 set
        print("setNickname \(nickname)")

        var signupUserModel = SignupUserModel()
        signupUserModel.nickname = nickname
        
        // 2. after goToLocationAndYears
        self.goToLocationAndYears(signupUserModel)
    }
}

extension NicknameViewModel: NicknameViewModelType {
    func goToLocationAndYears(_ signupUserModel: SignupUserModel) {
        delegate.goToLocationAndYears(signupUserModel)
    }
}
