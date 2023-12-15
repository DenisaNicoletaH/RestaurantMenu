//
//  AddEmployeesView.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/30/23.
//

import SwiftUI
struct AddEmployeesView: View {
    @State private var name: String = ""
    @Binding var employees: [Employees]
    @State private var showAlert: Bool = false
    @ObservedObject var employees_VM: Employees_ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Employee")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            TextField("Employee Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .foregroundColor(.black)
            
            Button("Add") {
                employees_VM.addEmployees(name: name)
                employees.append(Employees(employee_name: name, active: false))
                showAlert = true
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Employee Added"),
                    message: Text("You have successfully added the employee: \(name)"),
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
       // .border(Color.black, width: 1)
    }
}

    

    

struct AddEmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Employees_ViewModel()
               let employees: [Employees] = [] 
               
               return AddEmployeesView(employees: .constant(employees), employees_VM: viewModel)
           }
}
