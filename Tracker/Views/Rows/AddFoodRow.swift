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
            NavigationLink(destination: FoodDetailView(food: food).navigationTitle(food.name), label: {
                VStack {
                    Text(food.name)
                        .bold()
                        .font(.title)
                        .padding()
                    Text("Brand: \(food.brand)")
                    Text("Serving Size: \(food.servingSize)")
                }
                
            })
                .padding()
        }
    }
}

struct AddFoodRow_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodRow(food: Food(name: "Pizza", brand: "" , servingSize: "1 slice", calories: 1, protein: 1, carbs: 1, fat: 1))
    }
}
