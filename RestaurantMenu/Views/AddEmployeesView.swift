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
        VStack {
            Text("Add Employee")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.blue)
            
            HStack {
                Text("Employee Name")
                TextField("Employee Name", text: $name)
                    .padding(5)
                    .border(Color.black, width: 1)
                    .background(Color.white)
                   // .frame(width:200)
            }
            
            Button("Add"){
                employees_VM.addEmployees(name: name)
                employees.append(Employees(employee_name: name, active: false))
                showAlert = true
                presentationMode.wrappedValue.dismiss()
            }
            

          //  .padding(.top, 50)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Employee Added"),
                    message: Text("You have successfully added the employee: \(name)"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
        .foregroundColor(Color.black)
        .padding()
        .border(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom),width:10)
        
    }
}
    

    

struct AddEmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Employees_ViewModel()
               let employees: [Employees] = [] 
               
               return AddEmployeesView(employees: .constant(employees), employees_VM: viewModel)
           }
}
