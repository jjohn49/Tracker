//
//  SetPreferences.swift
//  Tracker
//
//  Created by John Johnston on 6/22/22.
//

import SwiftUI



struct SetPreferencesView: View {
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    var body: some View{
        NavigationView {
            VStack{
                //maybe add a new view for weight and height
                MacroPreferences()
                    .navigationTitle("Account")
                
                Button(action: {
                    foodEnvVar.setPreferences = true
                    foodEnvVar.saveToDefaults()
                }, label: {
                    Text("Set Goals").padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 50))
                }).padding().background(.tint).foregroundColor(.white).cornerRadius(10)
            }
        }
    }
}

//this is hwere they are going to add there weight, their goal weight, and how long they want this to take in order to calculate how much they need to eat per day as a baseline
struct WeightPreferences: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    @State var tempWeight: String
    @State var tempIdealWeight: String
    var body: some View{
        VStack{
            TextField("Enter Weight in lbs.  Ex: 200", text: $tempWeight)
            TextField("Enter your ideal weight in lbs.  Ex: 180", text: $tempIdealWeight)
        }
    }
}

struct MacroPreferences: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        Form{
            //Text("The Date is: \(foodEnvVar.dateToStr())")
            Section(header: Text(""), content: {
                Text("Cals Per Day: \(foodEnvVar.totalCaloriesAllowedInADat)")
            })
            
            Section(header: Text("Macros"), content: {
                HStack {
                    Text("Protein Goal")
                    TextField("Protein Goal: ", value: $foodEnvVar.proteinGoal, formatter: NumberFormatter()).onSubmit {
                        foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.proteinGoal * 4
                        setPref()
                    }.padding()
                    Stepper{
                        Text("")
                    }onIncrement: {
                        foodEnvVar.proteinGoal += 1
                        foodEnvVar.totalCaloriesAllowedInADat += 4
                    } onDecrement: {
                        if foodEnvVar.proteinGoal > 0{
                            foodEnvVar.proteinGoal -= 1
                            foodEnvVar.totalCaloriesAllowedInADat -= 4
                        }
                    }
                }
                
                HStack {
                    Text("Carb Goal")
                    TextField("Carb Goal: ", value: $foodEnvVar.carbGoal, formatter: NumberFormatter()).onSubmit {
                        foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.carbGoal * 4
                        setPref()
                    }.padding()
                    Stepper{
                        Text("")
                    }onIncrement: {
                        foodEnvVar.carbGoal += 1
                        foodEnvVar.totalCaloriesAllowedInADat += 4
                    } onDecrement: {
                        if foodEnvVar.carbGoal > 0{
                            foodEnvVar.carbGoal -= 1
                            foodEnvVar.totalCaloriesAllowedInADat -= 4
                        }
                    }
                }
                
                HStack {
                    Text("Fat Goal")
                    TextField("Fat Goal: ", value: $foodEnvVar.fatGoal, formatter: NumberFormatter()).onSubmit {
                        foodEnvVar.totalCaloriesAllowedInADat += foodEnvVar.fatGoal * 8
                        setPref()
                    }.padding()
                    Stepper{
                        Text("")
                    }onIncrement: {
                        foodEnvVar.fatGoal += 1
                        foodEnvVar.totalCaloriesAllowedInADat += 8
                    } onDecrement: {
                        if foodEnvVar.fatGoal > 0{
                            foodEnvVar.fatGoal -= 1
                            foodEnvVar.totalCaloriesAllowedInADat -= 8
                        }
                    }
                }
            })
            
        }.padding()
    }
    
    func setPref() {
        if foodEnvVar.proteinGoal != 0 && foodEnvVar.carbGoal != 0 && foodEnvVar.fatGoal != 0 {
            foodEnvVar.calcTotalCalsAllowed()
        }
    }
}

struct SetPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        SetPreferencesView().environmentObject(FoodEnvVar())
    }
}
