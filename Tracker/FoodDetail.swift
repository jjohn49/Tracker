//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetail: View {
    
    @EnvironmentObject var foodListConsumed: FoodCosumedList
    
    var food: Food
    
    var body: some View {
        VStack{
            Text("Serving Size: " + food.servingSize)
            Text("Calories: " + String(food.calories))
            Text("Protein: " + String(food.protein))
            Text("Carbs: " + String(food.carbs))
            Text("Fat: " + String(food.fat))
            Button(action: {
                foodListConsumed.foodCosumedListVar.append(food)
                print(foodListConsumed.foodCosumedListVar)
                print("Added food to the enviorment variable")
            }, label: {
                Text("Add " + food.name + " To The Food Consumed List")
            })
        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: FoodList.list[0])
    }
}
