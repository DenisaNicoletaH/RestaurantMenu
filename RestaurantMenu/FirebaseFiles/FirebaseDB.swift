//
//  FirebaseDB.swift
//  RestaurantMenu
//
//  Created by user237116 on 12/10/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class Firestore_DatabaseManager:NSObject{
    static let firestoreDB=Firestore_DatabaseManager()
    private override init(){}
    
    func createRecipe(recipes:Recipe){
        let db = Firestore.firestore()
        
        do{
            try db.collection("Recipes").document(recipes.id).setData(from:recipes)
        }
        catch{
            print("createRecipe database Error")
        }
        
    }
    
    func getRecipe(completion: @escaping ([Recipe]?, Error?)->Void){
        let db = Firestore.firestore()
        var recipesArr: [Recipe] = []
        
        db.collection("Recipes").getDocuments { (snapshot,error) in
            if let error = error{
                completion(nil,error)
            }else if let snapshot = snapshot{
                for document in snapshot.documents{
                    do{
                        let recipes = try document.data(as: Recipe.self)
                        recipesArr.append(recipes)
                    }catch{
                        completion(nil,error)
                    }
                }
            completion(recipesArr,nil)
            }
            
        }
        
    }
    
    
    func updateRecipe(id: String, recipe: Recipe, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()

        do {
            let data = try Firestore.Encoder().encode(recipe)
            db.collection("Recipes").document(id).updateData(data) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        } catch {
            completion(error)
        }
    }
    
    func getRecipesById(id: String, completion: @escaping (Recipe?, Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("Recipes").document(id).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists {
                do {
                    let recipe = try document.data(as: Recipe.self)
                    completion(recipe, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
            }
        }
    }

    func deleteRecipe(id: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("Recipes").document(id).delete { error in
            completion(error)
        }
    }
    
    
}

