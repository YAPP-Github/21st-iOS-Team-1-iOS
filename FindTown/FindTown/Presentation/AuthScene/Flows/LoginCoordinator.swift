//
//  LoginCoordinator.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/29.
//

import UIKit

import FindTownCore

final class LoginCoordinator: FlowCoordinator {
    
    var presentationStyle: PresentationStyle
    weak var navigationController: UINavigationController?
    
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
    
    internal func initScene() -> UIViewController {
        let loginViewModel = LoginViewModel(delegate: self,
                                            userDefaults: UserDefaultUtil(),
                                            kakaoManager: KakaoSigninManager())
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        return loginViewController
    }
}

extension LoginCoordinator: LoginViewModelDelegate {
    
    func goToTabBar() {
        guard let navigationController = navigationController else { return }
        navigationController.isNavigationBarHidden = true
        TabBarCoordinator(presentationStyle: .push(navigationController: navigationController)).start()
    }
    
    func goToNickname() {
        guard let navigationController = navigationController else { return }
        SignupCoordinator(presentationStyle: .push(navigationController: navigationController)).start()
    }
}
