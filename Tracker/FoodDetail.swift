//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetail: View {
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var food: Food
    
    var body: some View {
        VStack{
            Text("Serving Size: " + food.servingSize)
            Text("Calories: " + String(food.calories))
            Text("Protein: " + String(food.protein))
            Text("Carbs: " + String(food.carbs))
            Text("Fat: " + String(food.fat))
            Button(action: {
                updateFoodEnvVars(food: food)
            }, label: {
                Text("Add " + food.name + " To The Food Consumed List")
            })
        }
    }
    
    func updateFoodEnvVars(food:Food){
        foodEnvVar.foodCosumedListVar.append(food)
        foodEnvVar.totalCaloriesConsumedInADay += food.calories
        foodEnvVar.totalProteinConsumedInADay += food.protein
        foodEnvVar.totalCarbsConsumedInADay += food.carbs
        foodEnvVar.totalFatConsumedInADay += food.fat
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: FoodList.list[0])
    }
}


