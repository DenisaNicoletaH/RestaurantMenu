//
//  Recipe_ViewModel.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import Foundation


class Recipe_ViewModel: ObservableObject {

    @Published
    var recipes : [Recipe] = []
    @Published var drink: DrinkResult? = nil

    
    func addRecipe(name: String, type: String, description: String) {
        let newRecipe = Recipe(recipe_name: name, recipe_type: type, recipe_descripton: description)
        Firestore_DatabaseManager.firestoreDB.createRecipe(recipes: newRecipe)
        getAllRecipes()
    }

    
    func getAllRecipes(){
        Firestore_DatabaseManager.firestoreDB.getRecipe { (recipesRes,error) in
            if let error = error{
                print("get recipes database error \(error)")
            }
            else if let recipesRes = recipesRes{
                self.recipes = recipesRes
            }
        }
    }
    func deleteRecipe(id: String, navigationHandler: @escaping () -> Void) {
        Firestore_DatabaseManager.firestoreDB.deleteRecipe(id: id) { [weak self] error in
            if let error = error {
                print("Error deleting recipe: \(error)")
            } else {
                print("Recipe deleted successfully")
                self?.recipes.removeAll(where: { $0.id == id })
                navigationHandler()
            }
        }
    }
    
    
    func getRandomDrink(){
        FindMeADrinkApiService.API_service.fetchAll(completion: {data in
            self.drink = data?.drinks.first
        })
    }


    
    func editRecipe(id: String, updatedName: String, updatedType: String, updatedDescription: String, completion: @escaping () -> Void) {
            if let index = recipes.firstIndex(where: { $0.id == id }) {
                recipes[index].recipe_name = updatedName
                recipes[index].recipe_type = updatedType
                recipes[index].recipe_descripton = updatedDescription
                
                Firestore_DatabaseManager.firestoreDB.updateRecipe(id: id, recipe: recipes[index]) { error in
                    if let error = error {
                        print("Error updating recipe: \(error)")
                    } else {
                        print("Recipe updated successfully")
                        completion()
                    }
                }
            }
        }
}
