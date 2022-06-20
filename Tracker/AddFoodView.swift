//
//  AddFoodView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct AddFoodView: View {
    
    //This means you expect an enviorment variable to be passed but do not create one
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    @StateObject var hits = FoodResponse()
    
    var foodInList: [Food] = FoodList.list
    var body: some View {
        VStack{
            //need the id stuff because it is a custom structure
            //this takes everything in foodlist and puts it in the list
            /*List(foodInList, id: \.id) { food in
                VStack{
                    NavigationLink(destination: FoodDetail(food: food).navigationTitle(food.name), label: {
                        Text(food.name)
                    })
                        .padding()
                }
            }*/
            
            //Add a search bar that takes the user input and sends it to the api
            List{
                ForEach(hits.foodSearchRespnse, id: \.self){ hit in
                    let tempFood = Food(name: hit.fields.item_name, servingSize: hit.fields.nf_serving_size_unit, calories: Int(hit.fields.nf_calories), protein: Int(hit.fields.nf_protein), carbs: Int(hit.fields.nf_total_carbohydrate), fat: Int(hit.fields.nf_total_fat))
                    AddFoodRow(food: tempFood)
                }
            }.onAppear {
                print("Did this start?")
                hits.getResponse()
                print("ended")
            }
        }
    }
}
    



struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        //should update the previews when creating an enviorment object
        AddFoodView().environmentObject(FoodEnvVar())
    }
}
