//
//  WelcomeView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                NutritionView()
                    .navigationTitle("Nutrition Facts")
                NavigationLink(destination: Text("Food List"), label: {
                    Text("Add Food")
                })
            }
        }
    }
}

struct NutritionView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
