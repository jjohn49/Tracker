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
                NutritionView(caloriesAllowed: foodEnvVar.totalCaloriesAllowedInADat, caloriesConsumed: foodEnvVar.totalCaloriesConsumedInADay, proteinConsumed: foodEnvVar.totalProteinConsumedInADay, carbsConsumed: foodEnvVar.totalCarbsConsumedInADay, fatsConsumed: foodEnvVar.totalFatConsumedInADay)
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
        }.environmentObject(foodEnvVar).onAppear{
            foodEnvVar.fetchFromDefaults()
            foodEnvVar.isItANewDay()
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
    var caloriesAllowed: Int
    var caloriesConsumed : Int
    
    var proteinConsumed: Int
    var carbsConsumed: Int
    var fatsConsumed: Int
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
    func getPercentage()->Float{
        return Float(caloriesConsumed)/Float(caloriesAllowed)
    }
    
    var body: some View {
        let caloriesLeft = caloriesAllowed - caloriesConsumed
        NavigationView {
            VStack{
                Text("Calories Left: " + String(caloriesAllowed - caloriesConsumed))
                ProgressView(value: getPercentage())
                    .padding()
                VStack{
                    Text("Protein: " + String(proteinConsumed) + "g")
                    ProgressView(value: 0.5)
                    
                    Text("Carbs: " + String(carbsConsumed) + "g")
                    ProgressView(value: 0.5)
                    
                    Text("Fat: " + String(fatsConsumed) + "g")
                    ProgressView(value: 0.5)
                }
                .padding()
                //add better styling
                .border(.black)
            }
            .padding()
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



