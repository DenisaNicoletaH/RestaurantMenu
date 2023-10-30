//
//  Employees_ViewModel.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/28/23.
//

import Foundation

class Employees_ViewModel: ObservableObject {
    
    @Published
    var employees : [Employees] = [
        Employees(employee_name: "Jane",active:false),
        Employees(employee_name: "Sebastian",active:false),
        Employees(employee_name: "Jack",active:false),
        Employees(employee_name: "Alice",active:false)
    ]
    
    
    func addEmployees(name: String) {
        let newEmployee = Employees(employee_name: name, active : false)
        employees.append(newEmployee)
        
    }
    
    func toggleEmployee(employee: Employees){
        
    }
}
