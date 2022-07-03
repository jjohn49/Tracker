//
//  NutritionView.swift
//  Tracker
//
//  Created by John Johnston on 7/2/22.
//

import SwiftUI

struct NutritionView: View {
    
    //maybe make these enviorment variables so that they can be changed by multiple views
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
    func getPercentage(consumed: Float, allowed: Float)->Float{
        return consumed/allowed
    }
    
    //created this because i don't want to modify foodEnvVar.Date
    @State var selecteddDate: Date
    
    var body: some View {
        let caloriesLeft = foodEnvVar.totalCaloriesAllowedInADat - foodEnvVar.totalCaloriesConsumedInADay
        NavigationView {
            VStack{
                //this date picker will allow you to access the data from other days
                //Text(String(foodEnvVar.isItANewDay()))
                
                DatePicker("", selection: $foodEnvVar.date, displayedComponents: [.date])
                    .frame(alignment: .center)
                VStack {
                    Text("Calories Left: " + String(caloriesLeft)).padding().font(.title2)
                    ProgressView(value: getPercentage(consumed: foodEnvVar.totalCaloriesConsumedInADay, allowed: foodEnvVar.totalCaloriesAllowedInADat))
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                }.background(.mint).cornerRadius(10)
                VStack{
                    Text("Protein: " + String(foodEnvVar.totalProteinConsumedInADay) + "g")
                    ProgressView(value: getPercentage(consumed: foodEnvVar.totalProteinConsumedInADay, allowed: foodEnvVar.proteinGoal))
                        .progressViewStyle(RoundedRectProgressViewStyle())
                    
                    Text("Carbs: " + String(foodEnvVar.totalCarbsConsumedInADay) + "g")
                    ProgressView(value: getPercentage(consumed: foodEnvVar.totalCarbsConsumedInADay, allowed: foodEnvVar.carbGoal)).progressViewStyle(RoundedRectProgressViewStyle())
                    Text("Fat: " + String(foodEnvVar.totalFatConsumedInADay) + "g")
                    ProgressView(value: getPercentage(consumed: foodEnvVar.totalFatConsumedInADay, allowed: foodEnvVar.fatGoal)).progressViewStyle(RoundedRectProgressViewStyle())
                }
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 20, trailing: 30))
                .background(.tint)
                .cornerRadius(10)
                //add better styling
                /*Button(action: {
                    foodEnvVar.totalCaloriesConsumedInADay = 0
                    foodEnvVar.totalProteinConsumedInADay = 0
                    foodEnvVar.totalCarbsConsumedInADay = 0
                    foodEnvVar.totalFatConsumedInADay = 0
                    foodEnvVar.saveToDefaults()
                }, label: {
                    Text("Clear")
                })*/
            }
            .navigationTitle("Macros")
        }
    }
}


struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView(selecteddDate: FoodEnvVar().date).environmentObject(FoodEnvVar())
    }
}
