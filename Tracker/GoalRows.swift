//
//  GoalRows.swift
//  Tracker
//
//  Created by John Johnston on 6/22/22.
//

import SwiftUI

struct CalorieGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Calorie Goal:").padding(20).font(.headline)
            Text("\(foodEnvVar.totalCaloriesAllowedInADat)").padding(20)
            Text("gs").padding()
            Text("Per Day").padding()
        }.background(.orange).cornerRadius(10).padding(1)
    }
}

struct ProteinGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Protein Goal: ").padding(20).font(.headline)
            TextField(String(foodEnvVar.proteinGoal), value: $foodEnvVar.proteinGoal, formatter: NumberFormatter()).padding(10).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.proteinGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
            } onDecrement: {
                foodEnvVar.proteinGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
            }.padding()

        }.background(.tint).cornerRadius(10).padding(5)
    }
}

struct CarbGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Carb Goal: ").padding(20).font(.headline)
            TextField(String(foodEnvVar.carbGoal), value: $foodEnvVar.carbGoal, formatter: NumberFormatter()).padding(10).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.carbGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
            } onDecrement: {
                foodEnvVar.carbGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
            }.padding()

        }.background(.tertiary).cornerRadius(10).padding(5)
    }
}

struct FatGoalRow: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        HStack{
            Text("Fat Goal: ").padding(21).font(.headline)
            TextField(String(foodEnvVar.fatGoal), value: $foodEnvVar.fatGoal, formatter: NumberFormatter()).padding(10).background(.gray).cornerRadius(20).onSubmit {
                foodEnvVar.calcTotalCalsAllowed()
            }
            Text("gs").font(.footnote)
            Stepper {
                Text("")
            } onIncrement: {
                foodEnvVar.fatGoal+=1
                foodEnvVar.calcTotalCalsAllowed()
            } onDecrement: {
                foodEnvVar.fatGoal-=1
                foodEnvVar.calcTotalCalsAllowed()
            }.padding()

        }.background(.indigo).cornerRadius(10).padding(5)
    }
}


struct GoalRows_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CalorieGoalRow()
            
            ProteinGoalRow()
            
            CarbGoalRow()
            
            FatGoalRow()
        }.environmentObject(FoodEnvVar())
    }
}
