//
//  Coctails.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 23/2/23.
//

import Foundation

struct Coctails: Decodable{
    var drinks: [DrinkModel]?
}

struct DrinkModel: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var strInstructions: String
}
