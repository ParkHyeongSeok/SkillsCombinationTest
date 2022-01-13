//
//  EndPointType.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import Foundation
import Alamofire


/// should implement func asURLRequest() throws -> URLRequest
protocol EndPointType: URLRequestConvertible {
    var baseURLString: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: RequestParams { get }
    
}

extension EndPointType {
    
    /// Alamofire URLRequestConvertible extension method
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseURLString) else {
            throw NetworkError.urlConvert
        }
        
        guard var urlRequest = try? URLRequest(url: url.appendingPathComponent(self.path), method: self.httpMethod, headers: nil) else {
            throw NetworkError.urlRequestConvert
        }
        
        switch self.parameters {
        case .query(let request):
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}
