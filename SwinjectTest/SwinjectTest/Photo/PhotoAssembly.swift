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
        
        container.register(NetworkManagerType.self, name: "Alamofire") { resolver in
            return AlamofireManager()
        }
        
        container.register(NetworkManagerType.self, name: "Moya") { resolver in
            return MoyaManager()
        }
        
        container.register(NetworkManagerType.self, name: "Mock") { resolver in
            return MockNetworkManager()
        }
        
        container.register(PhotoReactor.self) { resolver in
            let networkManager = safeResolver.resolve(NetworkManagerType.self, name: "Alamofire")!
            return PhotoReactor(networkManager: networkManager)
        }
        
        container.register(PhotoViewController.self) { resolver in
            let photoReactor = safeResolver.resolve(PhotoReactor.self)!
            let photoVC = PhotoViewController()
            photoVC.reactor = photoReactor
            return photoVC
        }
    }
}
