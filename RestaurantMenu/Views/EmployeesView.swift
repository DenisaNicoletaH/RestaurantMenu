//
//  EmployeesView.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/28/23.
//

import SwiftUI

struct EmployeesDetail: View {
    @Binding var employee: Employees  // Pass the employee as a binding
        
        var body: some View {
            HStack {
                Text(employee.employee_name)
                    .font(.title)
                    .fontWeight(.black)
                Spacer()
            }
            VStack {
                Button(action: {
                    employee.active.toggle()
                }) {
                    Text(employee.active ? "WORKING" : "NOT WORKING")
                        .font(employee.active ? .system(size: 20) : .system(size: 14)) 

                }
                .frame(width: 100, height: 20, alignment: .center)
                .padding(5)
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
                    List(employees, id: \.id) { employee in EmployeesDetail(employee: $employees[employees.firstIndex(of: employee)!])
                            .foregroundColor(employee.active ? Color.green : Color.red)
                    }
                    .navigationBarTitle("Employees")
                }
                .foregroundColor(Color.green)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
                .border(Color.black, width: 1)
                .navigationBarItems(trailing:
                                        NavigationLink(destination: AddEmployeesView(employees: $employees, employees_VM: employees_VM)) {
                   
                    Label("Employees", systemImage: "person.fill")
                    Text("Add Employees")
                        .font(Font.system(size: 10))
                
                }
                )
            }
            .onAppear {
                // Initialize the employees array with the data from the view model
                employees = employees_VM.employees
            }
        }
    }


    struct EmployeesView_Previews: PreviewProvider {
        @State static var employeeActive = true
        
        static var previews: some View {
            EmployeesView()
        }
    
}
