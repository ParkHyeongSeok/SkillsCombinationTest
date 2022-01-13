//
//  PhotoEndPoint.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation
import Alamofire

enum PhotoEndPoint {
    case searchPhoto(String)
}

extension PhotoEndPoint: EndPointType {
    var baseURLString: String {
        return "https://api.unsplash.com/"
    }
    
    var path: String {
        switch self {
        case .searchPhoto:
            return "/search/photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchPhoto:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchPhoto(let request):
            return .query(request)
        }
    }
}
