//
//  Order.swift
//  CoffeAppMVVM
//
//  Created by Jorge de Carvalho on 03/01/22.
//

import Foundation

enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case expressino
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

class Order: Codable {
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
}
