//
//  PhotoAssembly.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import Swinject

class PhotoAssembly: Assembly {
    func assemble(container: Container) {
        let safeResolver = container.synchronize()
        
        container.register(UnsplashAPIType.self, name: "Alamofire") { resolver in
            return UnsplashAPI()
        }
        
        container.register(PhotoReactor.self) { resolver in
            let unsplashAPI = safeResolver.resolve(UnsplashAPIType.self, name: "Alamofire")!
            return PhotoReactor(unsplashAPI: unsplashAPI)
        }
        
        container.register(PhotoViewController.self) { resolver in
            let photoReactor = safeResolver.resolve(PhotoReactor.self)!
            let photoVC = PhotoViewController()
            photoVC.reactor = photoReactor
            return photoVC
        }
    }
}
