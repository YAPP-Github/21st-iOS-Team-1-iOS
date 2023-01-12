//
//  UserDefaultUtil.swift
//  FindTown
//
//  Created by 김성훈 on 2023/01/10.
//

import Foundation

struct UserDefaultUtil {
    
    private let USER_NICKNAME = "USER_NICKNAME"
    
    let instance: UserDefaults
    
    init() {
        instance = UserDefaults.standard
    }
    
    var userNickname: String {
        get {
            return self.instance.string(forKey: USER_NICKNAME) ?? ""
        }
        set {
            self.instance.set(newValue, forKey: USER_NICKNAME)
        }
    }
    
    func clear() {
        self.instance.removeObject(forKey: USER_NICKNAME)
    }
}
