//
//  Order.swift
//  CoffeAppMVVM
//
//  Created by Jorge de Carvalho on 03/01/22.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case expressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    init?(_ viewModel: AddCoffeeOrderViewModel) {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let coffeeType = CoffeeType(rawValue: viewModel.selectedType!.lowercased()),
              let coffeeSize = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else {
                  return nil
              }
        
        self.name = name
        self.email = email
        self.type = coffeeType
        self.size = coffeeSize
    }
}
