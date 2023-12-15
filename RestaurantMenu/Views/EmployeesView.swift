//
//  EmployeesView.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/28/23.
//

import SwiftUI


struct EmployeesDetail: View {
    @Binding var employee: Employees
    
    var body: some View {
        HStack {
            Text(employee.employee_name)
                .font(.title)
                .fontWeight(.black)
            Spacer()
            Button(action: {
                employee.active.toggle()
            }) {
                Text(employee.active ? "WORKING" : "NOT WORKING")
                    .font(employee.active ? .system(size: 16, weight: .bold) : .system(size: 14))
            }
            .frame(width: 120, height: 30)
            .padding(5)
            .background(employee.active ? Color.green : Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}
struct EmployeesView: View {
    @StateObject var employees_VM = Employees_ViewModel()
    @State private var employees: [Employees] = []
    @State private var isAddEmployeeViewPresented = false
    @State private var scrollToBottom: Bool = false // Added state variable for scrolling

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                ScrollViewReader { proxy in // Wrap the content in ScrollViewReader
                    List(employees, id: \.id) { employee in
                        EmployeesDetail(employee: $employees[employees.firstIndex(of: employee)!])
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("Employees")
                    .onChange(of: employees.count) { _ in
                        if scrollToBottom {
                            withAnimation {
                                proxy.scrollTo(employees.last?.id)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .onAppear {
                employees = employees_VM.employees
            }
            .navigationBarItems(trailing:
                Button(action: {
                    isAddEmployeeViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            )
            .sheet(isPresented: $isAddEmployeeViewPresented) {
                AddEmployeesView(employees: $employees, employees_VM: employees_VM)
                    .onAppear {
                        scrollToBottom = true
                    }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .accentColor(.white)
    }
}


    struct EmployeesView_Previews: PreviewProvider {
        @State static var employeeActive = true
        
        static var previews: some View {
            EmployeesView()
        }
    
}
