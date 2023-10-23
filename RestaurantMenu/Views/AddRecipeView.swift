//
//  AddRecipeView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct addRecipesStruct{
        @ObservedObject var viewModel: Recipe_ViewModel

        var body: some View {
            NavigationView {
                List(viewModel.recipes) { recipe in
                    Text(recipe.recipe_name)
                }
                .navigationBarItems(trailing:
                    NavigationLink("Add Recipe", destination: AddRecipeView(viewModel: viewModel))
                )
            }
        }
}

struct AddRecipeView: View {
    @State public var name:String=""
    @State public var diet:String=""
    @State public var description:String=""
    @State public var showAlert:Bool=false
    @ObservedObject var viewModel: Recipe_ViewModel

    
    var body: some View {

        VStack{
            Text("Add Recipe")
                .font(.largeTitle)
                .padding(.top,20)
            
            HStack{
                Text("Recipe Name:")
                TextField("Recipe Name", text: $name)
                    .padding()
            }
            HStack{
                Text("Recipe Diet:")
                TextField("Diet",text:$diet).padding()
            }
            
            
            HStack{
                Text("Recipe Description:")
                TextField("Description", text:$description)
                    .padding()
            }
            
            
            Button("Add") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Recipe Added"),
                    message: Text("You have successfully added the recipe: \(name)"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
        .padding()
       
    }
}
   


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: Recipe_ViewModel())
    }
}
