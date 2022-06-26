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
                foodEnvVar.updateFoodEnvVars(food: food)
            }, label: {
                Text("Add " + food.name + " To The Food Consumed List")
            })
        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: Food(name: "", brand: "", servingSize: "", numOfServ: 0, calories: 0, protein: 0, carbs: 0, fat: 0))
    }
}


