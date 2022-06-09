//
//  AddFoodView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct AddFoodView: View {
    
    //connects the variables from the view with the variable that has @State
    @EnvironmentObject var foodConsumedList: FoodCosumedList
    
    
    var foodInList: [Food] = FoodList.list
    var body: some View {
        VStack{
            //need the id stuff because it is a custom structure
            //this takes everything in foodlist and puts it in the list
            List(foodInList, id: \.id) { food in
                VStack{
                    NavigationLink(destination: FoodDetail(food: food).navigationTitle(food.name), label: {
                        Text(food.name)
                    })
                        .padding()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
