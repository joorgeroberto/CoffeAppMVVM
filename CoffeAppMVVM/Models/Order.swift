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
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(viewModel: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(viewModel)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error enconding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
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
