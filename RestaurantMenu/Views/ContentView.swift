//
//  ContentView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI


struct EditRecipeView: View {
    @ObservedObject var recipe_VM: Recipe_ViewModel
    @Binding var isPresented: Bool
    @State private var updatedName: String
    @State private var updatedType: String
    @State private var updatedDescription: String
    var recipe: Recipe
    

    init(recipe: Recipe, isPresented: Binding<Bool>, viewModel: Recipe_ViewModel) {
        self.recipe = recipe
        self._isPresented = isPresented
        self.recipe_VM = viewModel
        self._updatedName = State(initialValue: recipe.recipe_name)
        self._updatedType = State(initialValue: recipe.recipe_type)
        self._updatedDescription = State(initialValue: recipe.recipe_descripton)
    }

    var body: some View {
        VStack {
            TextField("Name", text: $updatedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Type", text: $updatedType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Description", text: $updatedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                recipe_VM.editRecipe(
                    id: recipe.id,
                    updatedName: updatedName,
                    updatedType: updatedType,
                    updatedDescription: updatedDescription
                ) {
                    isPresented = false
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("Edit Recipe")
    }
}


struct RecipeDetail: View {
    let recipe: Recipe
    var viewModel=Recipe_ViewModel()
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditViewPresented = false


    
    var body: some View {
        VStack {
            if recipe.recipe_type == "Vegetarian" {
                Image("VegetarianMenu")
                    .resizable()
                    .scaledToFit()
            }
            else if recipe.recipe_type == "Carnivore"{
                Image("MeatMenu")
                    .resizable()
                    .scaledToFit()
            }
            else if recipe.recipe_type == "Pescivore"{
                Image("FishMenu")
                    .resizable()
                    .scaledToFit()
            }
            else if recipe.recipe_type == "Pasta"{
                Image("PastaMenu")
                    .resizable()
                    .scaledToFit()
            }
            
            
            else{
                Text("")
            }
            Text("Name:\(recipe.recipe_name)").padding()
            Text("Type: \(recipe.recipe_type)").padding()
            Text(recipe.recipe_descripton).padding()
            Button("Edit") {
                           isEditViewPresented.toggle()
                       }
                       .sheet(isPresented: $isEditViewPresented) {
                           NavigationView {
                               EditRecipeView(recipe: recipe, isPresented: $isEditViewPresented, viewModel: viewModel)
                           }
                       }
     
            Button("Delete") {
                           showAlert = true
                       }
                       .alert(isPresented: $showAlert) {
                           Alert(
                               title: Text("Confirm Delete"),
                               message: Text("Are you sure you want to delete this recipe?"),
                               primaryButton: .destructive(Text("Delete")) {
                                   viewModel.deleteRecipe(id: recipe.id) {
                                       presentationMode.wrappedValue.dismiss()
                                   }
                               },
                               secondaryButton: .cancel()
                           )
                       }
                   }
               }
           }

struct ContentView: View {
    
    @ObservedObject var recipe_VM=Recipe_ViewModel()
    @State var goToAddRecipeView=false
    @State var employeeActive = false
    @State var recipes: [Recipe]
    @State var searchText=""
    @State var searchedRecipe: Recipe?
    
    func searchRecipe() {
        searchedRecipe = recipes.first { recipe in
            return recipe.recipe_name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    
    
    
    
    var body: some View {
        VStack{
            NavigationView {
                VStack {
                    TextField("Search Recipes", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Search"){
                        searchRecipe()
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .border(.white, width: 1)
                    .background(Color.green)
                    .frame(width: 200)
                    
                    //when u search
                    if let searchedRecipe = searchedRecipe {
                        RecipeDetail(recipe: searchedRecipe)
                            .background(Color.white)
                            .border(Color.black)
                        
                    }
                    
                    
                    List(recipe_VM.recipes, id: \.id) { recipe in
                        
                        
                        NavigationLink(destination: RecipeDetail(recipe: recipe, viewModel: recipe_VM)
                            .border(.white,width:1)){
                                ScrollView{
                                    VStack{
                                        //the main list page
                                        Text(recipe.recipe_name)
                                            .font(.headline)
                                        
                                        Text(recipe.recipe_type)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                }
                            }
                        
                    }
                    .toolbar {
                        
                        // Add Recipe button
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddRecipeView(viewModel: recipe_VM, recipes: $recipes)) {
                                Label("Recipe", systemImage: "book.fill")
                                Text("Add Recipes")
                                    .font(Font.system(size: 10))
                            }
                            .navigationViewStyle(StackNavigationViewStyle())
                        }
                        
                        // Timer button
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: DrinksView(vm: recipe_VM)) {
                                Label("Drinks", systemImage:"mug.fill")
                                Text("Drink")
                                    .font(Font.system(size: 10))
                            }
                            .navigationViewStyle(StackNavigationViewStyle())
                            
                        }
                        
                        // Employees button
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: EmployeesView()) {
                                Label("Employees", systemImage: "person.fill")
                                Text("Employees")
                                    .font(Font.system(size: 10))
                            }
                            .navigationViewStyle(StackNavigationViewStyle())
                            .padding(20)
                        }
                        
                        
                    }
                    
                    
                    .foregroundColor(Color.blue)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1),.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                    .border(.black, width: 1)
                     
                }
            }
           
        }.onAppear {
            print("Get drink")
            recipe_VM.getRandomDrink()
            recipe_VM.getAllRecipes()
        }
    }

    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView(recipes: [Recipe]())
        }
    }
}
