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
        }
    }
}


struct EmployeesView: View {
    
    @State var employees_VM = Employees_ViewModel()
       @State var addEmployee = false
       @State private var searchText = ""
       @State private var active = false
       @State var recipe_VM = Recipe_ViewModel()
       @State var goToAddRecipeView = false
       @State var employeeSelection: String?
       @State var employees: [Employees] = []

    var body: some View {
        NavigationView {
                 VStack {
                     List(employees_VM.employees, id: \.employee_name) { employee in
                         Label(employee.employee_name, systemImage: "person.fill")
                             .foregroundColor(employee.active ? Color.green : Color.red)
                             .onTapGesture {
                                 print(employee.active)
                             }
                     }
                     .navigationBarTitle("Employees")
                 }
                 .foregroundColor(Color.green)
                 .padding()
                 .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
                 .border(Color.black, width: 1)
                 .navigationBarItems(trailing:
                     NavigationLink(destination: AddEmployeesView(employees: $employees, employees_VM: Employees_ViewModel())) {
                         Text("Add Employees")
                     }
                 )
             }
         }
     }

    struct EmployeesView_Previews: PreviewProvider {
        @State static var employeeActive = true
        
        static var previews: some View {
            EmployeesView()
        }
    
}
