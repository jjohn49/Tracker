//
//  FoodConsumedRow.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI

struct FoodConsumedRow: View {
    var food: Food
    var body: some View {
        VStack(alignment: .center){
            Text(String(food.numOfServ) + "x " + food.name).bold()
                .padding().font(.title)
            HStack{
                Text(String(food.calories) + " / ")
                Text(String(food.protein) + " / ")
                Text(String(food.carbs) + " / ")
                Text(String(food.fat))
            }.font(.subheadline)
        }
        
    }
        
}

struct FoodConsumedRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodConsumedRow(food: Food(name: "Burger", servingSize: "1 patty", calories: 500, protein: 30, carbs: 10, fat: 20))
    }
}
