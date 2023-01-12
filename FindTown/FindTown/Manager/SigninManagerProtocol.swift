//
//  SignUpManagerProtocol.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/04.
//

import Foundation

import RxSwift

protocol SigninManagerProtocol {
    func signin() -> Observable<SigninRequest>
    
    func signout() -> Observable<Void>
    
    func logout() -> Observable<Void>
}

// 따로 분리
struct SigninRequest {
    var signinType: SigninType
    var accessToken: String
    var refreshToken: String
    
    var params: [String : Any] {
        return [
            "signinType": self.signinType.value,
            "accessToken": self.accessToken,
            "refreshToken": self.refreshToken,
        ]
    }
}

// 따로 분리
enum SigninType {
    case kakao
    case apple
    case anonymous
    case unknown
    
    init(value: String) {
        switch value {
        case "KAKAO":
            self = .kakao
            
        case "APPLE":
            self = .apple
            
        case "ANONYMOUS":
            self = .anonymous
            
        default:
            self = .unknown
        }
    }
}

extension SigninType {
    var value: String {
        switch self {
        case .kakao:
            return "KAKAO"
            
        case .apple:
            return "APPLE"
            
        case .anonymous:
            return "ANONYMOUS"
            
        case .unknown:
            return ""
        }
    }
}
