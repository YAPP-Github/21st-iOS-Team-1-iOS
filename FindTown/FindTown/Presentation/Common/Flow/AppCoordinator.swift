//
//  AppCoordinator.swift
//  FindTown
//
//  Created by 이호영 on 2022/12/25.
//

import UIKit
import FindTownCore
import KakaoSDKAuth
import KakaoSDKUser

public final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var userDefaults: UserDefaultUtil
    
    required init(
        navigationController: UINavigationController,
        userDefaults: UserDefaultUtil
    ) {
        self.navigationController = navigationController
        self.userDefaults = userDefaults
    }
    
    public func start() {
        
        // 자동 로그인
        
        if TokenManager.shared.readAccessToken() == nil {
            // 로그인 필요
            goToAuth()
        } else {
            // 1. server로 부터 유저정보 확인
            // 2. 유저정보가 있으면 goToTabBar()
            // 3. 없으면 goToAuth()

//            goToAuth()
            goToTabBar()
        }
    }
    
    private func goToAuth() {
        navigationController.isNavigationBarHidden = true
        LoginCoordinator(presentationStyle: .push(navigationController: navigationController)).start()
    }
    
    private func goToTabBar() {
        navigationController.isNavigationBarHidden = true
        TabBarCoordinator(presentationStyle: .push(navigationController: navigationController)).start()
    }
}
