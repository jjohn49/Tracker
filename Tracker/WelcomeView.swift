//
//  WelcomeView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

//creates the enviorment variable that can be shared throughout views
// all enviorment variables have to conform to the OBServableObject class
class FoodEnvVar: ObservableObject{
    @Published var foodCosumedListVar: [Food] = []
    
    @Published var totalCaloriesAllowedInADat: Int = 2000
    @Published var totalCaloriesConsumedInADay: Int = 0
    
}

struct WelcomeView: View {
    
    @StateObject var foodEnvVar = FoodEnvVar()
    
    var body: some View {
        NavigationView{
            VStack{
                NutritionView(caloriesAllowed: foodEnvVar.totalCaloriesAllowedInADat, caloriesConsumed: foodEnvVar.totalCaloriesConsumedInADay)
                    .navigationTitle("Nutrition Facts")
                foodCosumedView()
                NavigationLink(destination: AddFoodView().navigationTitle("Add Food"), label: {
                    Text("Add Food To List")
                }).padding()
            }
        }
        //put the variable foodListConsumed which is part of the custom class so that
        //all views within the navigation view have access to the variable
        .environmentObject(foodEnvVar)
    }

}

struct foodCosumedView: View{
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    
    var body: some View{
        
        List(foodEnvVar.foodCosumedListVar, id: \.id) { foodConsumed in
            Text(foodConsumed.name)
        }
    }
}

struct NutritionView: View {
    
    //maybe make these enviorment variables so that they can be changed by multiple views
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
        Group {
            WelcomeView()        }
    }
}


