//
//  RecipeModel.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import Foundation


struct Recipe:Identifiable,Codable{
    var id=UUID().uuidString
    var recipe_name:String
    var recipe_type:String
    var recipe_descripton:String
}



