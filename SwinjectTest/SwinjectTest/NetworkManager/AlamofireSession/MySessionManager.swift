//
//  MySessionManager.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation
import Alamofire

final class MySessionManager {
    
    // 인터셉터
    let interception = Interceptor()
    
    // 로거
    
    // 세션
    var session = Session.default
    
}
