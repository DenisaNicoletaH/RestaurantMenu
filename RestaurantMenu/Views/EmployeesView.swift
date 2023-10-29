//
//  EmployeesView.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/28/23.
//

import SwiftUI

struct EmployeesDetail: View {
    @State private var active: Bool = false
    @Binding var employeeActive: Bool

    var body: some View {
        VStack {
            Button(action: {
                self.active.toggle() // Toggle the 'active' state
            }) {
                Text(active ? "WORKING" : "NOT WORKING")
                    .font(.system(size: 24))
            }
            .frame(width: 300, height: 75, alignment: .center)
            .padding(.all, 20)
            .background(active ? Color.green : Color.red)
        }
    }
}


struct EmployeesView: View {
    
    @State var employees_VM=Employees_ViewModel()
    @State var addEmployee=false
    @State private var searchText=""
    @State private var active:Bool=false
    @Binding var employeeActive: Bool
    @State var recipe_VM=Recipe_ViewModel()
    @State var goToAddRecipeView=false
    @State var employeeSelection:String?
    
    var body: some View {
        VStack {
        NavigationView{
                List(employees_VM.employees, id: \.employee_name) { employee in
                    Label(employee.employee_name,systemImage: "person.fill")
                            .foregroundColor(employeeActive ? Color.green : Color.red)
                        .onTapGesture {
                            employeeActive.toggle()
                        
                    }
                }
                .navigationBarTitle("Employees")
            }
        
    }

}
    
    struct EmployeesView_Previews: PreviewProvider {
        @State static var employeeActive = true
        
        static var previews: some View {
            EmployeesView(employeeActive: $employeeActive)
        }
    }
}
