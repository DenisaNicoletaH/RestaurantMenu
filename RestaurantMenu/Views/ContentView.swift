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
        }
    }
}

struct ContentView: View {
    
    @State var recipe_VM=Recipe_ViewModel()
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
                    List(recipes, id: \.recipe_name) { recipe in
                        NavigationLink(destination: RecipeDetail(recipe: recipe)
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
                            NavigationLink(destination: TimerView()) {
                                Label("Timer", systemImage: "clock.fill")
                                Text("Timer")
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
                    .background(LinearGradient(gradient: Gradient(colors: [.blue,.green]), startPoint: .top, endPoint: .bottom))
                    .border(.black, width: 1)
                }
                .onAppear {
                    self.recipes = recipe_VM.recipes
                }
                
            }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView(recipes: [Recipe]())
        }
    }
}
