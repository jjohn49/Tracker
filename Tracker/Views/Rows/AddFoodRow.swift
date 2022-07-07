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
            NavigationLink(destination: FoodDetailView(food: food), label: {
                VStack {
                    Text(food.name)
                        .bold()
                        .font(.title)
                        .padding()
                    Text("Brand: \(food.brand)")
                    Text("Serving Size: \(food.servingSizeQty) \(food.prefferedUnit)")
                }
                
            })
                .padding()
        }
    }
}

struct AddFoodRow_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodRow(food: Food(name: "Pizza", brand: "" , servingSizeQty: 1, prefferedUnit: "g", unitOfMeasurement: "", calories: 1, protein: 1, carbs: 1, fat: 1))
    }
}
