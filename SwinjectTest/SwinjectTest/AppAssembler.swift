//
//  AppAssembler.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import Foundation
import Swinject

class AppAssembler {
    static let assembler = Assembler([
        PhotoAssembly()
    ])
}
