//
//  AddFoodRow.swift
//  Tracker
//
//  Created by John Johnston on 6/20/22.
//

import SwiftUI

struct AddFoodRow: View {
    var food: Food
    var body: some View {
        VStack{
            NavigationLink(destination: FoodDetail(food: food).navigationTitle(food.name), label: {
                Text(food.name)
            })
                .padding()
        }
    }
}

struct AddFoodRow_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodRow(food: Food(name: "a", servingSize: "q", calories: 1, protein: 1, carbs: 1, fat: 1))
    }
}
