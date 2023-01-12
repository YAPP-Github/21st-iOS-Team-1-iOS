//
//  TokenManager.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/12.
//

import Foundation

class TokenManager {
    
    static let shared = TokenManager()
    
    private init() {}
    
    func createTokens(accessToken: String, refreshToken: String) {
        do {
            try KeyChainManager.shared.create(account: .accessToken, data: accessToken)
            try KeyChainManager.shared.create(account: .refreshToken, data: refreshToken)
        } catch {
            print(error)
        }
    }
    
    func readAccessToken() -> String? {
        do {
            let accessToken = try KeyChainManager.shared.read(account: .accessToken)
            return accessToken
        } catch {
            print(error)
            return nil
        }
    }
    
    func readRefreshToken() -> String? {
        do {
            let refreshToken = try KeyChainManager.shared.read(account: .refreshToken)
            return refreshToken
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteTokens() {
        do {
            try KeyChainManager.shared.delete(account: .accessToken)
            try KeyChainManager.shared.delete(account: .refreshToken)
        } catch {
            print(error)
        }
    }
}
