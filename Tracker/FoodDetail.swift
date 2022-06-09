//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetail: View {
    
    var food: Food
    
    var body: some View {
        VStack{
            Text("Serving Size: " + food.servingSize)
            Text("Calories: " + String(food.calories))
            Text("Protein: " + String(food.protein))
            Text("Carbs: " + String(food.carbs))
            Text("Fat: " + String(food.fat))
        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: FoodList.list[0])
    }
}
