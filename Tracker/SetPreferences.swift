//
//  SetPreferences.swift
//  Tracker
//
//  Created by John Johnston on 6/22/22.
//

import SwiftUI



struct SetPreferences: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    var body: some View{
        NavigationView {
            VStack{
                //maybe add a new view for weight and height
                MacroPreferences()
                    .navigationTitle("Set Goals")
                
                Button(action: {
                    foodEnvVar.setPreferences = true
                }, label: {
                    Text("Set Goals").padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 50))
                }).padding().background(.tint).foregroundColor(.white).cornerRadius(10)
                
                
            }
        }
    }
}

struct MacroPreferences: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        VStack{
            //Text("The Date is: \(foodEnvVar.dateToStr())")
            Text("Cals Per Day: \(foodEnvVar.totalCaloriesAllowedInADat)").font(.title).padding()
            
            HStack {
                Text("Protein Goal").padding().font(.title3)
                TextField("Protein Goal: ", value: $foodEnvVar.proteinGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.proteinGoal * 4
                    setPref()
                }.padding()
            }
            
            HStack {
                Text("Carb Goal").padding().font(.title3)
                TextField("Carb Goal: ", value: $foodEnvVar.carbGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.carbGoal * 4
                    setPref()
                }.padding()
            }
            
            HStack {
                Text("Fat Goal").padding().font(.title3)
                TextField("Fat Goal: ", value: $foodEnvVar.fatGoal, formatter: NumberFormatter()).onSubmit {
                    foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.fatGoal * 8
                    setPref()
                }.padding()
            }
        }.padding()
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
