//
//  RestaurantMenuApp.swift
//  RestaurantMenu
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore



//I added this whole method for firebase ---------------------------------------
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }

   // let db = Firestore.firestore()
}
// -------------------------------------------------------------------------------


@main
struct RestaurantMenuApp: App {
    @StateObject private var viewModel = Recipe_ViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate //i added this for firebase


    var body: some Scene {
        WindowGroup {
            ContentView(recipes:[Recipe]())
        }
    }
}
