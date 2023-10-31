//
//  AddRecipeView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI


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
    @Environment(\.presentationMode) var presentationMode

       

    var body: some View {
        NavigationView{
            VStack{
                Text("Add Recipe")
                    .font(.largeTitle)
               //  .padding(.bottom,50)
                
                
                HStack{
                    Text("Recipe Name:")
                    TextField("Recipe Name", text: $name)
                        .padding(5)
                        .border(.black, width: 1)
                        .background(Color.white)
                        .frame(width: 200)
                }
                      HStack{
                          Text("Recipe Diet:")
                          TextField("Diet",text:$diet)
                              .padding(5)
                              .border(.black, width: 1)
                              .background(Color.white)
                              .frame(width: 200)

                      }
                
                
                HStack{
                    Text("Recipe Description:")
                    TextField("Description/How to do it", text:$description)
                        .padding(10)
                        .border(.black, width: 1)
                        .background(Color.white)
                        .frame(width: 280)
                }
                
                
                Button("Add") {
                    viewModel.addRecipe(name: name, type: diet, description: description)
                    recipes.append(Recipe(recipe_name: name, recipe_type: diet, recipe_descripton: description))
                    presentationMode.wrappedValue.dismiss();                    showAlert = true
                    
                    
                }.padding(.top,50)
                    
                    .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Recipe Added"),
                        message: Text("You have successfully added the recipe: \(name)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .foregroundColor(Color.black)
            
                    
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.green,.blue ]),startPoint: .top,endPoint:.bottom))
        .border(.black, width: 1)
    }
       

    
    
}
struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Recipe_ViewModel()
        
        return AddRecipeView(viewModel: viewModel, recipes: .constant([]))
    }
}
