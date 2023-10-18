//
//  Recipe_ViewModel.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import Foundation


class Recipe_ViewModel: ObservableObject {
    
    @Published
    var recipes : [Recipe] = [
        Recipe(recipe_name: "Salad", recipe_type: "Vegetarian", recipe_descripton:"It is a green salad"),
    Recipe(recipe_name: "Steak", recipe_type: "Meat", recipe_descripton:"It is a steak"),
        Recipe(recipe_name: "Mac & Cheese", recipe_type: "Pasta", recipe_descripton:"It is fancy pasta")

    
    ]

}
