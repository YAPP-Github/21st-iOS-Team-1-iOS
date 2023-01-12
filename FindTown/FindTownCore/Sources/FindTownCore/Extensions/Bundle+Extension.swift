//
//  File.swift
//  
//
//  Created by 김성훈 on 2022/12/30.
//

import Foundation

extension Bundle {
    
    public var NAVER_MAP_KEY: String {
        guard let file = self.path(forResource: "APIKeyInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["NMFClientId"] as? String else { fatalError("NMFClientId error") }
        
        return key
    }
    
    public var KAKAO_NATIVE_APP_KEY: String {
        guard let file = self.path(forResource: "APIKeyInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["KakaoNativeAppKey"] as? String else { fatalError("KakaoNativeAppKey error") }
        
        return key
    }
}
