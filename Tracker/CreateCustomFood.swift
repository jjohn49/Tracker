//
//  CreateCustomFood.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI

struct CreateCustomFood: View {
    
    @State var foodName: String = ""
    @State var foodBrand: String = ""
    @State var foodServingSize: String = ""
    @State var foodAmount: Float = 0
    @State var foodCals: Float = 0
    @State var foodPro: Float = 0
    @State var foodCarbs: Float = 0
    @State var foodFat: Float = 0
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        VStack{
            inputFoodDetails(foodName: $foodName, foodServingSize: $foodServingSize, foodAmount: $foodAmount, foodCals: $foodCals, foodPro: $foodPro, foodCarbs: $foodCarbs, foodFat: $foodFat)
            Button (action: {
                foodEnvVar.updateFoodEnvVars(food: createFood())
                //maybe add soemthing that will send this to the database
            }, label: {
                Text("Create and Add Custom Food")
            })
            
        }.padding()
    }
    func createFood() -> Food{
        return Food(name: foodName, brand: foodBrand, servingSize: foodServingSize, calories: foodCals, protein: foodPro, carbs: foodCarbs, fat: foodFat)
    }
    
    
}

struct inputFoodDetails: View{
    @Binding var foodName: String
    @Binding  var foodServingSize: String
    @Binding var foodAmount: Float
    @Binding  var foodCals: Float
    @Binding  var foodPro: Float
    @Binding  var foodCarbs: Float
    @Binding  var foodFat: Float
    var body: some View{
       NameServingSizeAndAmount(name: $foodName, servingSize: $foodServingSize, amount: $foodAmount)
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

struct NameServingSizeAndAmount: View{
     @Binding var name: String
    @Binding var servingSize: String
     @Binding var amount: Float
    
    var body: some View{
        TextField("Food Name", text: $name).padding()
        TextField("Serving Size", text: $servingSize).padding()
        Text("Amount")
        TextField("Food Amount", value: $amount, formatter: NumberFormatter())
    }
}

struct CreateCustomFood_Previews: PreviewProvider {
    static var previews: some View {
        CreateCustomFood()
    }
}
