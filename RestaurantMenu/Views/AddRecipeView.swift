//
//  AddRecipeView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI
/*
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
 */

struct AddRecipeView: View {
    @State public var name:String=""
    @State public var diet:String=""
    @State public var description:String=""
    @State public var showAlert:Bool=false
    @ObservedObject var viewModel: Recipe_ViewModel
    @Binding var recipes:[Recipe]
    @State var recipe_VM=Recipe_ViewModel()
    @State var goToAddRecipeView=false
    @State private var searchText=""
    @State private var employeeActive = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Add Recipe")
                 .font(.largeTitle)
                HStack{
                    Text("Recipe Name:")
                    TextField("Recipe Name", text: $name)
                }
                HStack{
                    Text("Recipe Diet:")
                    TextField("Diet",text:$diet).padding()
                }
                
                
                HStack{
                    Text("Recipe Description:")
                    TextField("Description", text:$description)
                }
                
                
                Button("Add") {
                    viewModel.addRecipe(name: name, type: diet, description: description)
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
            }
        }
    
    
}
   

/*
struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: Recipe_ViewModel(), viewModel:viewModel)

    }
 */

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Recipe_ViewModel()
        
        return AddRecipeView(viewModel: viewModel, recipes: .constant([]))
    }
}
