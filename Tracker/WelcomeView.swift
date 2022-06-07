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
                NutritionView(caloriesAllowed: 2000, caloriesConsumed: 100)
                    .navigationTitle("Nutrition Facts")
                NavigationLink(destination: Text("Food List"), label: {
                    Text("Add Food")
                })
            }
        }
    }

}

struct NutritionView: View {
    
    var caloriesAllowed: Int
    var caloriesConsumed : Int
    
    func getPercentage()->Float{
        return Float(caloriesConsumed)/Float(caloriesAllowed)
    }
    
    var body: some View {
        var caloriesLeft = caloriesAllowed - caloriesConsumed
        VStack{
            Text("Calories Left: " + String(caloriesAllowed - caloriesConsumed))
            ProgressView(value: getPercentage())
                .padding()
            VStack{
                Text("Protein")
                ProgressView(value: 0.5)
                
                Text("Carbs")
                ProgressView(value: 0.5)
                
                Text("Fat")
                ProgressView(value: 0.5)
            }
            .padding()
            .border(.black)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


