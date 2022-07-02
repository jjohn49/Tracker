//
//  FoodConsumedListView.swift
//  Tracker
//
//  Created by John Johnston on 7/2/22.
//

import SwiftUI

struct FoodConsumedListView: View{
    
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
                    .toolbar{
                        NavigationLink(destination: {
                            AddFoodView()
                        }, label: {
                            Text("Add Food")
                        })
                    }
                    .navigationTitle("Food Consumed")
                }
            } else {
                VStack {
                    Text("You Haven't Eaten Today")
                    NavigationLink(destination: {
                        AddFoodView()
                    }, label: {
                        Text("Add Food")
                    }).padding().background(.tint).foregroundColor(.white).cornerRadius(10)
                        .navigationTitle("No Food")
                }
            }
        }
    }
}


struct FoodConsumedListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodConsumedListView()
    }
}
