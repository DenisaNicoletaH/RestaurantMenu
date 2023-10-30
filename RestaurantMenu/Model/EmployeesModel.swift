//
//  EmployeesModel.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/28/23.
//

import Foundation


struct Employees:Identifiable,Equatable{
    var id=UUID()
    var employee_name:String
    var active:Bool //This defines if they are working or not
}
