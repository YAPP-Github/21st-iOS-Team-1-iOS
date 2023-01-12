//
//  AuthCoordinatorDelegate.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/05.
//

import Foundation

protocol SignupViewModelDelegate {
    func goToLocationAndYears(_ signupUserModel: SignupUserModel)
    func goToTownMood(_ signupUserModel: SignupUserModel)
    func goToFavorite(_ signupUserModel: SignupUserModel)
    func goToAgreePolicy(_ signupUserModel: SignupUserModel)
    func goToTabBar()
}
