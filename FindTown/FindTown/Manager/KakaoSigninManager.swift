//
//  KakaoSignUpManager.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/04.
//

import Foundation

import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import RxSwift

// 수정
enum BaseError: LocalizedError {
    case custom(String)
    case unknown
    case timeout
    case failDecoding
    case nilValue
    
    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        case .unknown:
            return "error_unknown"
        case .timeout:
            return "http_error_timeout"
        case .failDecoding:
            return "error_failed_to_json"
        case .nilValue:
            return "error_value_is_nil"
        }
    }
}

final class KakaoSigninManager: SigninManagerProtocol {
    
    private var disposeBag = DisposeBag()
    
    private var publisher = PublishSubject<SigninRequest>()
    
    func signin() -> Observable<SigninRequest> {
        self.publisher = PublishSubject<SigninRequest>()
        
        if UserApi.isKakaoTalkLoginAvailable() {
            self.signInWithKakaoTalk()
        } else {
            self.signInWithKakaoAccount()
        }
        return self.publisher
    }
    
    // logout API -> accessToken, refreshToken 날아감
    // signout : logoutAPI 호출 + KeyChain + userDefault, 서버 유저정보 다 날려야함
    func signout() -> Observable<Void> {
        return .create { observer in
            UserApi.shared.logout { error in
                if let kakaoError = error as? SdkError,
                   kakaoError.getApiError().reason == .InvalidAccessToken {
                    observer.onNext(())
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func logout() -> Observable<Void> {
        return .create { observer in
            UserApi.shared.logout { error in
                if let kakaoError = error as? SdkError,
                   kakaoError.getApiError().reason == .InvalidAccessToken {
                    observer.onNext(())
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private func signInWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { authToken, error in
            if let error = error {
                if let sdkError = error as? SdkError {
                    if sdkError.isClientFailed {
                        switch sdkError.getClientError().reason {
                        case .Cancelled:
                            self.publisher.onError(BaseError.custom("cancel"))
                        default:
                            let errorMessage = sdkError.getApiError().info?.msg ?? ""
                            let error = BaseError.custom(errorMessage)
                            
                            self.publisher.onError(error)
                        }
                    }
                } else {
                    let signInError
                    = BaseError.custom("error is not SdkError. (\(error.self))")
                    
                    self.publisher.onError(signInError)
                }
            } else {
                guard let authToken = authToken else {
                    self.publisher.onError(BaseError.custom("authToken is nil"))
                    return
                }
                let request = SigninRequest(
                    signinType: .kakao,
                    accessToken: authToken.accessToken,
                    refreshToken: authToken.refreshToken
                )

                self.publisher.onNext(request)
                self.publisher.onCompleted()
            }
        }
    }
    
    private func signInWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { authToken, error in
            if let error = error {
                if let sdkError = error as? SdkError {
                    if sdkError.isClientFailed {
                        switch sdkError.getClientError().reason {
                        case .Cancelled:
                            self.publisher.onError(BaseError.custom("cancel"))
                        default:
                            let errorMessage = sdkError.getApiError().info?.msg ?? ""
                            let error = BaseError.custom(errorMessage)
                            
                            self.publisher.onError(error)
                        }
                    }
                } else {
                    let signInError
                    = BaseError.custom("error is not SdkError. (\(error.self))")
                    
                    self.publisher.onError(signInError)
                }
            } else {
                guard let authToken = authToken else {
                    self.publisher.onError(BaseError.custom("authToken is nil"))
                    return
                }
                let request = SigninRequest(
                    signinType: .kakao,
                    accessToken: authToken.accessToken,
                    refreshToken: authToken.refreshToken
                )
                
                self.publisher.onNext(request)
                self.publisher.onCompleted()
            }
        }
    }
}
