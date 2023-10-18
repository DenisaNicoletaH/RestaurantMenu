//
//  ContentView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.recipe_name)
            Text("Type: \(recipe.recipe_type)")
            Text(recipe.recipe_descripton)
        }
    }
}

struct ContentView: View {
    var body: some View {
        @State var recipe_VM=Recipe_ViewModel()
        
        VStack{
            
            NavigationView {
                
                List(recipe_VM.recipes, id: \.recipe_name){
                    recipe in
                    NavigationLink(destination: RecipeDetail(recipe: recipe))
                    {
                        Text(recipe.recipe_name)
                    }
                }
                .navigationBarTitle("Menu")
                .toolbar(){
                    Button("Add Recipe"){
                        //Do the code for going to  }
                    }
                    
                }
            }
        }
                       .padding()
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
