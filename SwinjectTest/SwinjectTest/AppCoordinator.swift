//
//  AppCoordinator.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import UIKit
import Swinject

class AppCoordinator: CoordinatorType {
    var assembler: Assembler
    var navigationController: UINavigationController = UINavigationController()
    init(assembler: Assembler, navigationController: UINavigationController) {
        self.assembler = assembler
        self.navigationController = navigationController
    }
    
    func start() {
        let photoCoordinator = PhotoCoordinator(
            assembler: self.assembler,
            navigationController: self.navigationController)
        photoCoordinator.start()
    }
    
}
