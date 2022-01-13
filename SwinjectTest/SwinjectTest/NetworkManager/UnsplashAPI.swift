//
//  UnsplashAPI.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import Alamofire
import RxSwift

class UnsplashAPI: UnsplashAPIType {
    
    func search(_ query: String) -> Observable<[Photo]> {
        return Observable.create { observer in
            SessionManager
                .shared
                .session
                .request(MyRouter.searchPhoto(query))
                .validate(statusCode: 200...300)
                .response { response in
                    debugPrint(response)
                    observer.onNext([])
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }
}
