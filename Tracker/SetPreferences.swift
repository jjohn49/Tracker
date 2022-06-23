//
//  SetPreferences.swift
//  Tracker
//
//  Created by John Johnston on 6/22/22.
//

import SwiftUI



struct SetPreferences: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Cals Per Day: \(foodEnvVar.totalCaloriesAllowedInADat)").font(.title).padding()
                
                TextField("Protein Goal: ", value: $foodEnvVar.proteinGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.proteinGoal * 4
                    setPref()
                }.padding()
                
                TextField("Carb Goal: ", value: $foodEnvVar.carbGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.carbGoal * 4
                     setPref()
                }.padding()
                
                TextField("Fat Goal: ", value: $foodEnvVar.fatGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.fatGoal * 8
                    setPref()
                }.padding()
                
                Button(action: {
                    setPref()
                    foodEnvVar.setPreferences = true
                }, label: {
                    Text("Set Preferences")
                })
                
                .navigationTitle("Set Preferences")
            }
        }
    }
    
    func setPref() {
        if foodEnvVar.proteinGoal != 0 && foodEnvVar.carbGoal != 0 && foodEnvVar.fatGoal != 0 {
            foodEnvVar.calcTotalCalsAllowed()
        }
    }
}

struct SetPreferences_Previews: PreviewProvider {
    static var previews: some View {
        SetPreferences().environmentObject(FoodEnvVar())
    }
}
