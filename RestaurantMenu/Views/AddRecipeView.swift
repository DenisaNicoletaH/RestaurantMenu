//
//  AddRecipeView.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI



struct recipeName{

}

struct AddRecipeView: View {
    @State public var name:String=""
    @State public var diet:String=""
    @State public var description:String=""
    
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
        }
            .padding()
        }
    }

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
