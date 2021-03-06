//
//  CoordinatorType.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import UIKit
import Swinject

protocol CoordinatorType {
    var assembler: Assembler { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
