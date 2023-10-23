//
//  ContentView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

/*
func addRecipeLink(){
    var body:some View{
        NavigationView{
            NavigationLink(destination: AddRecipeView()){
                Text("Add Recipe")
            }
        }
    }
}
 */
 

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
    
    @State var recipe_VM=Recipe_ViewModel()
    @State var goToAddRecipeView=false
    @State private var searchText=""
    
    var body: some View {
        
        VStack{
            NavigationView{
                List(recipe_VM.recipes, id: \.recipe_name){
                    recipe in
                    NavigationLink(destination: RecipeDetail(recipe: recipe))
                    {
                        Text(recipe.recipe_name)
                    }
                }.navigationBarTitle("Menu")
                    .toolbar(){
                        NavigationLink(destination: AddRecipeView(viewModel:recipe_VM)){
                            Text("Add Recipes")
                        }
                        
                    }
                    .toolbar(){
                        NavigationLink(destination: TimerView()){
                            Text("Timer")
                        }
                        
                    }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
