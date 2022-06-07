//
//  AddFoodView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct AddFoodView: View {
    var foodInList: [Food] = FoodList.list
    var body: some View {
        VStack{
            //need the id stuff because it is a custom structure
            List(foodInList, id: \.id) { food in
                Text(food.name)
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
