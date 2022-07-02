//
//  GoalRows.swift
//  Tracker
//
//  Created by John Johnston on 6/22/22.
//

import SwiftUI

struct MacroGoalView: View{
    var body: some View{
        VStack{
            Text("Macro Goals").font(.title2).bold()
            CalorieGoalRow()
            ProteinGoalRow()
            CarbGoalRow()
            FatGoalRow()
        }
    }
}

struct CalorieGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Cals:").padding().font(.headline)
            let formattedString = String(format: "%.1f", foodEnvVar.totalCaloriesAllowedInADat)
            Text("\(formattedString)").padding()
            //Spacer()
            Text("gs")
            Text("Per Day").padding()
        }.background(.mint).cornerRadius(10)
        
        //maybe add like a pie chart or something to get a breakdown of what percentage each macronutrient takes up in the calorie breakdown
    }
}

struct ProteinGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Pro:  ").padding().font(.headline)
            TextField(String(foodEnvVar.proteinGoal), value: $foodEnvVar.proteinGoal, formatter: NumberFormatter()).padding(8).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.proteinGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            } onDecrement: {
                foodEnvVar.proteinGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            }.padding()

        }.background(.tint).cornerRadius(10)
    }
}

struct CarbGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Carb:").padding().font(.headline)
            TextField(String(foodEnvVar.carbGoal), value: $foodEnvVar.carbGoal, formatter: NumberFormatter()).padding(8).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.carbGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            } onDecrement: {
                foodEnvVar.carbGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            }.padding()

        }.background(.tertiary).cornerRadius(10)
    }
}

struct FatGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Fat:   ").padding().font(.headline)
            TextField(String(foodEnvVar.fatGoal), value: $foodEnvVar.fatGoal, formatter: NumberFormatter()).padding(8).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.fatGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            } onDecrement: {
                foodEnvVar.fatGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
                foodEnvVar.saveToDefaults()
            }.padding()

        }.background(.indigo).cornerRadius(10)
    }
}


struct GoalRows_Previews: PreviewProvider {
    static var previews: some View {
        MacroGoalView().environmentObject(FoodEnvVar())
    }
}
