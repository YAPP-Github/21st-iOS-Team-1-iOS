//
//  LoginCoordinator.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/29.
//

import UIKit

import FindTownCore

final class SignupCoordinator: FlowCoordinator {
    
    var presentationStyle: PresentationStyle
    weak var navigationController: UINavigationController?
    
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
    
    /// 로그인 화면
    internal func initScene() -> UIViewController {
        let loginViewModel = LoginViewModel(delegate: self)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        return loginViewController
    }
    
    /// 회원거입 닉네임 설정 화면
    internal func signUpNicknameScene() -> UIViewController {
        let nicknameViewModel = NicknameViewModel(delegate: self)
        let nicknameViewController = NicknameViewController(viewModel: nicknameViewModel)
        return nicknameViewController
    }

    /// 회원거입 첫번째 정보입력 화면 (위치, 몇년 거주)
    internal func signUpInputLocationAndYearsScene() -> UIViewController {
        let locationAndYearsViewModel = LocationAndYearsViewModel(delegate: self)
        let locationAndYearsViewController = LocationAndYearsViewController(viewModel: locationAndYearsViewModel)
        return locationAndYearsViewController
    }
    
    /// 회원거입 두번째 정보입력 화면 (동네 분위기)
    internal func signUpInputTownMoodScene() -> UIViewController {
        let townMoodViewModel = TownMoodViewModel(delegate: self)
        let townMoodViewController = TownMoodViewController(viewModel: townMoodViewModel)
        return townMoodViewController
    }
    
    /// 회원거입 관심 있는 동네
    
}

extension SignupCoordinator: SignupCoordinatorDelegate {
    
    func goToNickname() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(signUpNicknameScene(), animated: true)
    }
    
    func goToLocationAndYears() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(signUpInputLocationAndYearsScene(), animated: true)
    }
    
    func goToTownMood() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(signUpInputTownMoodScene(), animated: true)
    }
    
    func goToFavorite() {
        
    }
}