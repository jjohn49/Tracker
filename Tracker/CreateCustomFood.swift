//
//  CreateCustomFood.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI

struct CreateCustomFood: View {
    
    @State var foodName: String = ""
    @State var foodServingSize: String = ""
    @State var foodCals: Int = 0
    @State var foodPro: Int = 0
    @State var foodCarbs: Int = 0
    @State var foodFat: Int = 0
    
    var body: some View {
        VStack{
            inputFoodDetails(foodName: $foodName, foodServingSize: $foodServingSize, foodCals: $foodCals, foodPro: $foodPro, foodCarbs: $foodCarbs, foodFat: $foodFat)
            Button (action: {
                let food: Food = createFood()
                print("Worked")
            }, label: {
                Text("Create Custom Food")
            })
            
        }.padding()
    }
    func createFood() -> Food{
        return Food(name: foodName, servingSize: foodServingSize, calories: foodCals, protein: foodPro, carbs: foodCarbs, fat: foodFat)
    }
}

struct inputFoodDetails: View{
    @Binding var foodName: String
    @Binding  var foodServingSize: String
    @Binding  var foodCals: Int
    @Binding  var foodPro: Int
    @Binding  var foodCarbs: Int
    @Binding  var foodFat: Int
    var body: some View{
        TextField(" Food Name", text: $foodName).padding()
        TextField(" Serving Size", text: $foodServingSize).padding()
        Text("Calories")
        TextField("Calories",value: $foodCals, formatter: NumberFormatter())
        Text("Protein")
        TextField("Protein",value: $foodPro, formatter: NumberFormatter())
        Text("Carbs")
        TextField("Carbs",value: $foodCarbs, formatter: NumberFormatter())
        Text("Fat")
        TextField("Fat",value: $foodFat, formatter: NumberFormatter())
    }
}

struct CreateCustomFood_Previews: PreviewProvider {
    static var previews: some View {
        CreateCustomFood()
    }
}
