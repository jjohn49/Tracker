//
//  WelcomeView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

//creates the enviorment variable that can be shared throughout views
// all enviorment variables have to conform to the OBServableObject class

struct WelcomeView: View {
    
    @StateObject var foodEnvVar = FoodEnvVar()
    
    
    var body: some View {
        TabView{
            if !foodEnvVar.setPreferences {
                SetPreferences()
                //create a setPreferencesView
                //print("Set preferences is false")
                //foodEnvVar.setPreferences.toggle()
            }else{
                NutritionView()
                    .tabItem{
                        Label("Macros", systemImage: "leaf.circle")
                    }
                GoalsView()
                    .tabItem{
                        Label("Goals", systemImage: "flame.circle")
                    }
                foodCosumedView()
                    .tabItem{
                        Label("Food Consumed", systemImage: "pills.circle")
                    }
                AddFoodView()
                    .tabItem{
                        Label("Add Food", systemImage: "cross.circle")
                    }
            }
            //put the variable foodListConsumed which is part of the custom class so that
            //all views within the navigation view have access to the variable
        }.environmentObject(foodEnvVar)
            .onAppear{
            foodEnvVar.fetchFromDefaults()
            foodEnvVar.isItANewDay()
            //print(foodEnvVar.date)
        }
    }

}

struct GoalsView: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View{
        NavigationView{
            VStack{
                CalorieGoalRow()
                ProteinGoalRow()
                CarbGoalRow()
                FatGoalRow()
            }
            .navigationTitle("Goals")
            .toolbar{
                ToolbarItem(content: {
                    Button(action: {
                        foodEnvVar.setPreferences.toggle()
                    }, label: {
                        Label("Set Goals", systemImage: "brain")
                    })
                })
            }
        }
    }
}

struct foodCosumedView: View{
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    
    var body: some View{
        NavigationView{
            if !foodEnvVar.foodCosumedListVar.isEmpty{
                List {
                    ForEach(foodEnvVar.foodCosumedListVar) { food in
                        FoodConsumedRow(food: food)
                    }
                    .onDelete { indexSet in
                        let index = indexSet[indexSet.startIndex]
                        let foodToDelete: Food = foodEnvVar.foodCosumedListVar[index]
                        foodEnvVar.foodCosumedListVar.remove(atOffsets: indexSet)
                        foodEnvVar.totalCaloriesConsumedInADay -= foodToDelete.calories * foodToDelete.numOfServ
                        foodEnvVar.totalProteinConsumedInADay -= foodToDelete.protein * foodToDelete.numOfServ
                        foodEnvVar.totalCarbsConsumedInADay -= foodToDelete.carbs * foodToDelete.numOfServ
                        foodEnvVar.totalFatConsumedInADay -= foodToDelete.fat * foodToDelete.numOfServ
                        foodEnvVar.saveToDefaults()
                    }
                    .navigationTitle("Food Consumed")
                }
            } else {
                Text("You Haven't Eaten Today")
                    .navigationTitle("No Food")
            }
        }
    }
}


struct NutritionView: View {
    
    //maybe make these enviorment variables so that they can be changed by multiple views
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
    func getPercentage(consumed: Float, allowed: Float)->Float{
        return consumed/allowed
    }
    
    var body: some View {
        let caloriesLeft = foodEnvVar.totalCaloriesAllowedInADat - foodEnvVar.totalCaloriesConsumedInADay
        NavigationView {
            VStack{
                Text("For the Day of: \(foodEnvVar.dateToStrShortVersion())").font(.subheadline)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            .previewInterfaceOrientation(.portrait)        }
    }
}



