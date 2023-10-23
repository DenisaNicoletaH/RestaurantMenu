//
//  RestaurantMenuApp.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

@main
struct RestaurantMenuApp: App {
    @StateObject private var viewModel = Recipe_ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
