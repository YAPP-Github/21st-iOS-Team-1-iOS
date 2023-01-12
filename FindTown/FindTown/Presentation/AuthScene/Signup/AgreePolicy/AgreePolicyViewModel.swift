//
//  AgreePolicyViewModel.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/09.
//

import Foundation

import FindTownUI
import FindTownCore
import RxSwift
import RxRelay

protocol AgreePolicyViewModelType {
    func goToTabBar()
}

final class AgreePolicyViewModel: BaseViewModel {
    
    struct Input {
        let allAgree = PublishSubject<Bool>()
        let policy = PublishSubject<Bool>()
        let personalInfo = PublishSubject<Bool>()
        
        let confirmButtonTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let buttonsSelected = PublishRelay<Bool>()
        let confirmButtonEnabled = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    let delegate: SignupViewModelDelegate
    let signupUserModel: SignupUserModel
    
    init(
        delegate: SignupViewModelDelegate,
        signupUserModel: SignupUserModel
    ) {
        self.delegate = delegate
        self.signupUserModel = signupUserModel
        
        super.init()
        self.bind()
    }
    
    func bind() {
        
        self.input.allAgree
            .bind { [weak self] in
                self?.input.policy.onNext($0)
                self?.input.personalInfo.onNext($0)
                self?.output.buttonsSelected.accept($0)
            }
            .disposed(by: disposeBag)
        
        self.input.confirmButtonTrigger
            .bind(onNext: self.goToTabBar)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.policy, input.personalInfo)
            .map { (policy, personalInfo) in
                return policy && personalInfo
            }
            .bind { [weak self] in
                self?.output.confirmButtonEnabled.accept($0)
            }
            .disposed(by: disposeBag)
    }
}

extension AgreePolicyViewModel: AgreePolicyViewModelType {
    
    func goToTabBar() {
        print("signupUserModel \(signupUserModel)")
        delegate.goToTabBar()
    }
}
