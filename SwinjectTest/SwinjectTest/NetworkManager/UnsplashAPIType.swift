//
//  UnsplashAPIType.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation

protocol UnsplashAPIType {
    func search(_ query: String, completion: @escaping (Result<[Photo], NetworkError>) -> Void)
}
