//
//  UnsplashAPI.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import Alamofire

class UnsplashAPI: UnsplashAPIType {
    func search(_ query: String, completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        AF.request(PhotoEndPoint.searchPhoto(query))
            .reses
    }
}
