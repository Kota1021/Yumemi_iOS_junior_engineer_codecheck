//
//  FortuneAPI.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation
import Alamofire

struct FortuneAPI{
    private let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"
    private let endPoint = "/my_fortune"
    private let version = "v1"
    
}

extension FortuneAPI{
    public var headers:HTTPHeaders{ ["API-Version" : self.version] }
    public var url:URL{
        guard let url = URL(string: self.baseURL + self.endPoint) else {
            fatalError("API URL Broken")
        }
        return url
    }
}
