//
//  DrinkResponse.swift
//  RestaurantMenu
//
//  Created by user237116 on 12/14/23.
//

import Foundation


struct DrinkResponse: Codable{
    var drinks: [DrinkResult]
}

struct DrinkResult: Codable{
    var idDrink: String
    var strDrink: String
    var strCategory: String
    var strInstructions: String
    var strDrinkThumb:String //This is the Image
         
}
