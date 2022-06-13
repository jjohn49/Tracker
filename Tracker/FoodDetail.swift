//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetail: View {
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    @State var food: Food
    
    var body: some View {
        VStack{
            Text("Serving Size: " + food.servingSize)
            HStack{
                Text("Number of servings")
                TextField(String(food.numOfServ),value: $food.numOfServ, formatter: NumberFormatter())
            }
            Text("Calories: " + String(food.calories * food.numOfServ))
            Text("Protein: " + String(food.protein * food.numOfServ))
            Text("Carbs: " + String(food.carbs * food.numOfServ))
            Text("Fat: " + String(food.fat * food.numOfServ))
            Button(action: {
                updateFoodEnvVars(food: food)
            }, label: {
                Text("Add " + food.name + " To The Food Consumed List")
            })
        }
    }
    
    func updateFoodEnvVars(food:Food){
        foodEnvVar.foodCosumedListVar.append(food)
        foodEnvVar.totalCaloriesConsumedInADay += food.calories * food.numOfServ
        foodEnvVar.totalProteinConsumedInADay += food.protein * food.numOfServ
        foodEnvVar.totalCarbsConsumedInADay += food.carbs * food.numOfServ
        foodEnvVar.totalFatConsumedInADay += food.fat * food.numOfServ
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: FoodList.list[0])
    }
}


