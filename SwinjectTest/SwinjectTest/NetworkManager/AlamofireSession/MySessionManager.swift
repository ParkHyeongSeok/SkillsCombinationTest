//
//  MySessionManager.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation
import Alamofire

final class MySessionManager {
    static let shared = MySessionManager()
    
    // 인터셉터
    let interceptors = Interceptor(adapters: [], retriers: [], interceptors: [MyInterceptor()])
    
    // 로거
    let monitor = [MyLogger()] as [EventMonitor]
    // 세션
    var session: Session
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: monitor)
    }
    
}
