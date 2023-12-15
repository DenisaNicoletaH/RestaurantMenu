//
//  AddRecipeView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI
struct AddRecipeView: View {
    @State public var name: String = ""
    @State public var diet: String = ""
    @State public var description: String = ""
    @State public var showAlert: Bool = false
    @ObservedObject var viewModel: Recipe_ViewModel
    @Binding var recipes: [Recipe]
    @State var goToAddRecipeView = false
    @State private var searchText = ""
    @State private var employeeActive = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add Recipe")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recipe Name:")
                        .foregroundColor(.blue)
                    TextField("Recipe Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recipe Diet:")
                        .foregroundColor(.blue)
                    TextField("Diet", text: $diet)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recipe Description:")
                        .foregroundColor(.blue)
                    TextField("Description/How to do it", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                
                Button("Add") {
                    viewModel.addRecipe(name: name, type: diet, description: description)
                    recipes.append(Recipe(recipe_name: name, recipe_type: diet, recipe_descripton: description))
                    presentationMode.wrappedValue.dismiss()
                    showAlert = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Recipe Added"),
                        message: Text("You have successfully added the recipe: \(name)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            .padding()
            .border(Color.black, width: 1)
        }
    }
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Recipe_ViewModel()
        return AddRecipeView(viewModel: viewModel, recipes: .constant([]))
    }
}
