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
            else{
                Text("")
            }
            Text("Name:\(recipe.recipe_name)")
            Text("Type: \(recipe.recipe_type)")
            Text(recipe.recipe_descripton)
        }
    }
}

struct ContentView: View {
    
    @State var recipe_VM=Recipe_ViewModel()
    @State var goToAddRecipeView=false
    @State private var searchText=""
    @State private var employeeActive = false

    var body: some View {
        VStack{
            NavigationView{
                List(recipe_VM.recipes, id: \.recipe_name) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                        Text(recipe.recipe_name)
                            .font(.headline)
                        
                        Text(recipe.recipe_type)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                }
                .toolbar {
                    NavigationLink(destination: AddRecipeView(viewModel: recipe_VM, recipes: $recipe_VM.recipes)) {
                        Label("Recipe", systemImage:"book.fill")
                        Text("Add Recipes")
                            .font(Font.system(size: 10))
                        
                    }
                    .padding()
                }
                .toolbar {
                    NavigationLink(destination: TimerView()) {
                        Label("Timer",systemImage:"clock.fill")
                        Text("Timer")
                            .font(Font.system(size: 10))
                    }
                    .padding()
                }                .toolbar {
                    NavigationLink(destination: EmployeesView(employeeActive: $employeeActive)) {
                        Label("Employees", systemImage: "person.fill")
                        Text("Employees")
                            .font(Font.system(size: 10))
                    }
                    
                }
                .foregroundColor(Color.red)
                
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.green,.blue, .yellow ]),startPoint: .top,endPoint:.bottom))
            }          .padding(.bottom,20)
            
        }
    }
}
 
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
