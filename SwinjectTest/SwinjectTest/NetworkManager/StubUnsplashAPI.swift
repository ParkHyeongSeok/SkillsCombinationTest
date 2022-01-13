//
//  StubUnsplashAPI.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation

class StubUnsplashAPI: UnsplashAPIType {
    func search(_ request: URLRequest, completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        completion(.success([]))
    }
}
