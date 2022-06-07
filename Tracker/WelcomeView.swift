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
                NavigationLink(destination: AddFoodView().navigationTitle("Add Food"), label: {
                    Text("Add Food To List")
                })
            }
        }
    }

}

struct NutritionView: View {
    
    var caloriesAllowed: Int
    var caloriesConsumed : Int
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
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
            //add better styling
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


