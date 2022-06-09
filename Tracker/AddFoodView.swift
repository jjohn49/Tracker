//
//  AddFoodView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct AddFoodView: View {
    
    //This means you expect an enviorment variable to be passed but do not create one
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
        //should update the previews when creating an enviorment object
        AddFoodView().environmentObject(FoodCosumedList())
    }
}
