//
//  TimerView.swift
//  RestaurantMenu
//
//  Created by user237116 on 10/20/23.
//

import SwiftUI
import Foundation


struct TimerView: View {
    @ObservedObject var vm: Recipe_ViewModel

    var body: some View {
        VStack {
            Spacer()

            if let drink = vm.drink {
                VStack {
                    AsyncImage(url: URL(string: drink.strDrinkThumb)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(12)
                                .padding()
                        } else if phase.error != nil {
                            Text("Failed to load image")
                                .padding()
                        } else {
                            ProgressView()
                                .padding()
                        }
                    }

                    Text("Drink of the day:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    Text(drink.strDrink)
                        .font(.headline)
                        .padding(.top, 8)

                    Text("Category: \(drink.strCategory)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 4)

                    Text("Instructions:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 8)

                    Text(drink.strInstructions)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
            } else {
                Text("Loading...")
                    .padding()
            }

            Spacer()
        }
        .onAppear {
            vm.getRandomDrink()
        }
        .navigationBarTitle("Drink of the Day")
    }
}
