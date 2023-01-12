//
//  SignUpSecondViewModel.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/31.
//

import Foundation

import FindTownCore
import RxSwift
import RxRelay

protocol TownMoodViewModelType {
    func goToFavorite(_ signupUserModel: SignupUserModel)
}

final class TownMoodViewModel: BaseViewModel {
    
    struct Input {
        let townLikeText = PublishSubject<String>()
        let nextButtonTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let buttonsSelected = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    let delegate: SignupViewModelDelegate
    var signupUserModel: SignupUserModel
    
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
        
        self.input.nextButtonTrigger
            .withLatestFrom(input.townLikeText)
            .bind(onNext: settownLikeText)
            .disposed(by: disposeBag)
        
        self.input.townLikeText
            .bind { [weak self] in
                self?.output.buttonsSelected.accept($0.count < 20 ? false : true)
            }
            .disposed(by: disposeBag)
    }
    
    private func settownLikeText(townLikeText: String) {
        // 1. townLikeText 임시로 set
        print("townLikeText \(townLikeText)")
        
        // after goToFavorite
        signupUserModel.townLikeText = townLikeText
        self.goToFavorite(signupUserModel)
    }
}

extension TownMoodViewModel: TownMoodViewModelType {
    
    func goToFavorite(_ signupUserModel: SignupUserModel) {
        delegate.goToFavorite(signupUserModel)
    }
}
