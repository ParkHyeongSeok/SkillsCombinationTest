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
        let threadSafeContainer = container.synchronize()
        
        container.register(PhotoReactor.self) { resolver in
            return PhotoReactor()
        }
        
        container.register(PhotoViewController.self) { resolver in
            let photoReactor = threadSafeContainer.resolve(PhotoReactor.self)!
            let photoVC = PhotoViewController()
            photoVC.reactor = photoReactor
            return photoVC
        }
    }
}
