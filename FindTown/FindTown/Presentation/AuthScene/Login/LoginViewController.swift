//
//  LoginViewController.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/29.
//

import UIKit

import FindTownCore
import FindTownUI
import KakaoSDKUser
import RxCocoa
import RxSwift

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel?
    
    private let anonymousTitleTapGesture = UITapGestureRecognizer()
    
    // MARK: - Views
    
    // 추후에 수정
    
    private let tempLogo = FindTownLabel(text: "LOGO", font: .headLine1, textColor: .primary)
    
    private let subTitle = FindTownLabel(text: "내가 찾던 동네", font: .headLine3)
    
    private let introduceTitle = FindTownLabel(text: "동네 인프라부터 후기까지,\n나에게 맞는 동네를 찾아봐요!", font: .body3)
    
    private let kakaoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "카카오로 시작하기"
        configuration.image = UIImage(named: "KakaoIcon")
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)
        configuration.baseForegroundColor = FindTownColor.black.color
        configuration.imagePadding = 9
        configuration.attributedTitle?.font = FindTownFont.body1.font
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Apple로 시작하기"
        configuration.image = UIImage(named: "AppleIcon")
        configuration.baseBackgroundColor = FindTownColor.black.color
        configuration.baseForegroundColor = FindTownColor.white.color
        configuration.imagePadding = 9
        configuration.attributedTitle?.font = FindTownFont.body1.font
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let anonymousTitle = FindTownLabel(text: "둘러보기", font: .body3, textColor: .grey5)
    
    // MARK: - Life Cycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func addView() {
        [tempLogo, subTitle, introduceTitle, kakaoButton, appleButton, anonymousTitle].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            tempLogo.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: UIScreen.main.bounds.size.height / 3.5),
            tempLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: tempLogo.bottomAnchor, constant: 32),
            subTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            introduceTitle.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            introduceTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            kakaoButton.topAnchor.constraint(equalTo: introduceTitle.bottomAnchor,
                                             constant: UIScreen.main.bounds.size.height / 6),
            kakaoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kakaoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            kakaoButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: kakaoButton.bottomAnchor, constant: 12),
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            anonymousTitle.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 34),
            anonymousTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func setupView() {
        view.backgroundColor = .white
        
        introduceTitle.numberOfLines = 2
        introduceTitle.textAlignment = .center
        
        anonymousTitle.addGestureRecognizer(anonymousTitleTapGesture)
        anonymousTitle.isUserInteractionEnabled = true
    }
    
    override func bindViewModel() {
        
        // Input
        
        /// kakao 로그인
        kakaoButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.viewModel?.input.kakaoSigninTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        /// apple 로그인
        appleButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.viewModel?.input.appleSigninTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        /// 둘러보기
        anonymousTitleTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.viewModel?.input.anonymousTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        // Output
        
    }
}
