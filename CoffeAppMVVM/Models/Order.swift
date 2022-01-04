//
//  Order.swift
//  CoffeAppMVVM
//
//  Created by Jorge de Carvalho on 03/01/22.
//

import Foundation

enum CoffeType: String, Codable {
    case capuccino
    case lattee
    case expressino
    case cortado
}

enum CoffeSize: String, Codable {
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
