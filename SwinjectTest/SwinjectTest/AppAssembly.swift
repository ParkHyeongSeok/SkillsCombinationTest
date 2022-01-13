//
//  AppAssembly.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/14.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    func assemble(container: Container) {
        let resolver = container.synchronize()
        
        container.register(<#T##serviceType: Service.Type##Service.Type#>, name: <#T##String?#>, factory: <#T##(Resolver) -> Service#>)
    }
}
