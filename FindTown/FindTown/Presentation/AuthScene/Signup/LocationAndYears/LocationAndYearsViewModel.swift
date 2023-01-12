//
//  SignUpFirstInfoViewModel.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/30.
//

import Foundation

import FindTownCore
import RxSwift
import RxRelay

protocol LocationAndYearsViewModelType {
    func goToTownMood(_ signupUserModel: SignupUserModel)
}

// 수정
struct DongYearMonth {
    let dong: String
    let year: Int
    let month: Int
    
    init(dong: String = "", year: Int = 0, month: Int = 0) {
        self.dong = dong
        self.year = year
        self.month = month
    }
}

final class LocationAndYearsViewModel: BaseViewModel {
    
    struct Input {
        let dong = PublishSubject<String>()
        let year = BehaviorSubject<Int>(value: 0)
        let month = BehaviorSubject<Int>(value: 1)
        
        let dongYearMonth = BehaviorSubject<DongYearMonth>(
            value: DongYearMonth(dong: "", year: 0, month: 1)
        )
        
        let nextButtonTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let nextButtonEnabled = PublishRelay<Bool>()
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
            .withLatestFrom(input.dongYearMonth)
            .bind(onNext: setDongYearMonth)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.dong, input.year, input.month)
            .bind { [weak self] (dong, year, month) in
                self?.output.nextButtonEnabled.accept(true)
                let model = DongYearMonth(dong: dong, year: year, month: month)
                self?.input.dongYearMonth.onNext(model)
            }
            .disposed(by: disposeBag)
    }
    
    private func setDongYearMonth(dongYearMonth: DongYearMonth) {
        // 1. dongYearMonth 임시로 set
        print("dongYearMonth \(dongYearMonth)")
        
        if dongYearMonth.dong == "" {
            self.output.nextButtonEnabled.accept(false)
        } else {
            // 2. after goToTwonMood
            signupUserModel.dongYearMonth = dongYearMonth
            self.goToTownMood(signupUserModel)
        }
    }
}

extension LocationAndYearsViewModel: LocationAndYearsViewModelType {
    
    func goToTownMood(_ signupUserModel: SignupUserModel) {
        delegate.goToTownMood(signupUserModel)
    }
}
