//
//  PhotoCoordinator.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/14.
//

import UIKit
import Swinject

class PhotoCoordinator: CoordinatorType {
    var assembler: Assembler
    var navigationController: UINavigationController
    
    init(assembler: Assembler, navigationController: UINavigationController) {
        self.assembler = assembler
        self.navigationController = navigationController
    }
    
    func start() {
        let photoViewController = self.assembler.resolver.resolve(PhotoViewController.self)!
        photoViewController.coordinator = self
        navigationController.pushViewController(photoViewController, animated: false)
    }
    
    func navigatePhotoDetail(photo: Photo) {
        let photoDetailViewController = self.assembler.resolver.resolve(PhotoDetailViewController.self)!
        photoDetailViewController.rendering(photo: photo)
        navigationController.pushViewController(photoDetailViewController, animated: true)
    }
}

