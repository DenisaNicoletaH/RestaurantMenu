//
//  RecipeModel.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import Foundation


struct Recipe:Identifiable{
    var id=UUID()
    var recipe_name:String
    var recipe_type:String
    var recipe_descripton:String
}



