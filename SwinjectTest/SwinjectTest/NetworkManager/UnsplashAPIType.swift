//
//  UnsplashAPIType.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import RxSwift

protocol UnsplashAPIType {
    func search(_ query: String) -> Observable<[Photo]>
}
