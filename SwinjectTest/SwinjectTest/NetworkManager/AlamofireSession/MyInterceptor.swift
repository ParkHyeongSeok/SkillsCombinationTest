//
//  MyInterceptor.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation
import Alamofire

final class MyInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
    }
    
}
