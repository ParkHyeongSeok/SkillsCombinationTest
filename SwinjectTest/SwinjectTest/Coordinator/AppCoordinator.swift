//
//  AppCoordinator.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType? = nil
    var childCoordinator: [CoordinatorType] = []
    var navigationController: UINavigationController = UINavigationController()
    
    private(set) var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.rootViewController = AppAssembler.assembler.resolver.resolve(PhotoViewController.self)!
        window?.makeKeyAndVisible()
    }
    
}
