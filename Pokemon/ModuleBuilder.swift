//
//  ModuleBuilder.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit

protocol ModuleBuilder {
    associatedtype Module: UIViewController
    func build() -> Module
}
