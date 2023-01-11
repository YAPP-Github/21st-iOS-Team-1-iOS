//
//  SignUpNickNameViewController.swift
//  FindTown
//
//  Created by 김성훈 on 2022/12/29.
//

import UIKit

import FindTownCore
import FindTownUI
import RxCocoa
import RxSwift

final class NicknameViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: NicknameViewModel?
    
    // MARK: - Views
    
    private let nowStatusPogressView = UIProgressView(progressViewStyle: .bar)
    
    private let inputNickNameTitle = FindTownLabel(text: "닉네임을 입력해주세요", font: .subtitle4)
    
    private let nickNameTextField = FindTownTextField()
    
    private let duplicateButton = FTButton(style: .mediumTintedWithRadius)
    
    private let nickNameTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let nickNameStatusLabel = FindTownLabel(text: "", font: .label3)
    
    private let emptyView = UIView()
    
    private let nextButton = FTButton(style: .largeFilled)
    
    // MARK: - Life Cycle
    
    init(viewModel: NicknameViewModel) {
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
        
        view.addSubview(nowStatusPogressView)
        
        nickNameTextStackView.addArrangedSubview(nickNameTextField)
        nickNameTextStackView.addArrangedSubview(duplicateButton)
        
        [inputNickNameTitle, nickNameTextStackView, nickNameStatusLabel, emptyView, nextButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        super.addView()
    }
    
    override func setLayout() {
        nowStatusPogressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nowStatusPogressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nowStatusPogressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nowStatusPogressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nowStatusPogressView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            inputNickNameTitle.topAnchor.constraint(equalTo: super.contentView.topAnchor, constant: 46),
        ])
        
        NSLayoutConstraint.activate([
            duplicateButton.widthAnchor.constraint(equalToConstant: 74),
            duplicateButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height - (self.navigationController?.navigationBar.intrinsicContentSize.height ?? 0) - 100)
        ])
        
        stackView.setCustomSpacing(16, after: inputNickNameTitle)
        stackView.setCustomSpacing(8, after: nickNameTextStackView)
        
        super.setLayout()
    }
    
    override func setupView() {
        view.backgroundColor = .white
        
        nowStatusPogressView.trackTintColor = FindTownColor.grey2.color
        nowStatusPogressView.progressTintColor = FindTownColor.primary.color
        nowStatusPogressView.progress = Float(1) / 4.0
        
        nickNameTextField.delegate = self
        nickNameTextField.placeholder = "공백 포함 최대 10자, 특수문자 제외"
        
        nickNameStatusLabel.isHidden = true
        
        duplicateButton.setTitle("중복확인", for: .normal)
        duplicateButton.changesSelectionAsPrimaryAction = false
        duplicateButton.isSelected = true
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.changesSelectionAsPrimaryAction = false
        nextButton.isEnabledAndSelected(false)
    }
    
    override func bindViewModel() {
        
        // input
        
        nickNameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind { [weak self] in
                self?.viewModel?.input.nickname.onNext($0)
            }
            .disposed(by: disposeBag)
        
        duplicateButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.viewModel?.input.nickNameCheckTrigger.onNext(self?.nickNameTextField.text ?? "")
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.viewModel?.input.nextButtonTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        // output
        
        viewModel?.output.nickNameStatus
            .asDriver(onErrorJustReturn: .none)
            .drive { [weak self] in
                self?.nickNameStatusChange(nickNameStatus: $0)
            }
            .disposed(by: disposeBag)
    }
    
    private func nickNameStatusChange(nickNameStatus: NicknameStatus) {
        switch nickNameStatus {
        case .none:
            nickNameStatusLabel.isHidden = true
            buttonStatusChange(true)
        case .duplicate:
            nickNameStatusLabel.text = "이미 사용한 닉네임입니다."
            nickNameStatusLabel.textColor = FindTownColor.error.color
            nickNameStatusLabel.isHidden = false
            buttonStatusChange(true)
        case .complete:
            nickNameStatusLabel.text = "사용할 수 있는 닉네임입니다."
            nickNameStatusLabel.textColor = FindTownColor.success.color
            nickNameStatusLabel.isHidden = false
            buttonStatusChange(false)
        case .includeSpecialChar:
            nickNameStatusLabel.text = "특수문자는 입력할 수 없습니다."
            nickNameStatusLabel.textColor = FindTownColor.error.color
            nickNameStatusLabel.isHidden = false
            buttonStatusChange(true)
        }
    }
    
    private func buttonStatusChange(_ isStatus: Bool) {
        duplicateButton.isEnabledAndSelected(isStatus)
        nextButton.isEnabledAndSelected(!isStatus)
    }
}

extension NicknameViewController: UITextFieldDelegate {
    // 닉네임 글자 수 10글자로 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }
}
