//
//  AddCoffeeModelViewModel.swift
//  CoffeAppMVVM
//
//  Created by Jorge de Carvalho on 05/01/22.
//

import Foundation

struct AddCoffeeOrderViewModel {
    var name: String?
    var email: String?
    
    var types: [String] {
        return CoffeType.allCases.map { $0.rawValue.capitalized}
    }
    
    var sizes: [String] {
        return CoffeSize.allCases.map { $0.rawValue.capitalized}
    }
}
