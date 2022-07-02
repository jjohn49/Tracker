//
//  CreateCustomFood.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI

struct CreateCustomFoodView: View {
    
    @State var foodName: String = ""
    @State var foodBrand: String = ""
    @State var foodServingSize: String = ""
    @State var foodAmount: String = ""
    @State var foodCals: String = ""
    @State var foodPro: String = ""
    @State var foodCarbs: String = ""
    @State var foodFat: String = ""
    
    @State var inputIsNotEmpty: Bool = false
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View {
        VStack{
            inputFoodDetails(foodName: $foodName, foodBrand: $foodBrand, foodServingSize: $foodServingSize, foodAmount: $foodAmount, foodCals: $foodCals, foodPro: $foodPro, foodCarbs: $foodCarbs, foodFat: $foodFat)
            Button (action: {
                //makes sure everything is satisfied so the app doesn't crash
                if inputIsNotEmpty{
                    foodEnvVar.updateFoodEnvVars(food: createFood())
                    //maybe add soemthing that will send this to the database
                }else{
                    //add some alert here
                    foodEnvVar.updateFoodEnvVars(food: createFood())
                }
                
            }, label: {
                Text("Create and Add Custom Food").foregroundColor(.white).padding()
            }).background(.tint).cornerRadius(10)
            .navigationTitle("Custom Food")
        }.padding()
    }
    func createFood() -> Food{
        //chcks to see if all fields were satisfied
        if !foodName.isEmpty && !foodServingSize.isEmpty && !foodAmount.isEmpty && !foodCals.isEmpty && !foodPro.isEmpty && !foodCarbs.isEmpty && !foodFat.isEmpty {
            inputIsNotEmpty = true
            return Food(name: foodName, brand: foodBrand, servingSize: foodServingSize, calories: Float(foodCals)!, protein: Float(foodPro)!, carbs: Float(foodCarbs)!, fat: Float(foodFat)!)
        }
        return Food(name: "", brand: "", servingSize: "", calories: 0, protein: 0, carbs: 0, fat: 0)
    }
    
    
}

struct inputFoodDetails: View{
    @Binding var foodName: String
    @Binding var foodBrand: String
    @Binding  var foodServingSize: String
    @Binding var foodAmount: String
    @Binding  var foodCals: String
    @Binding  var foodPro: String
    @Binding  var foodCarbs: String
    @Binding  var foodFat: String
    var body: some View{
        NameServingSizeAndAmount(name: $foodName, brand: $foodBrand, servingSize: $foodServingSize, amount: $foodAmount)
        TextField("Calories Per Serving", text: $foodCals).background(.mint).font(.subheadline)
        TextField("Protein Per Serving", text: $foodPro).background(.mint).font(.subheadline)
        TextField("Carbs Per Serving", text: $foodCarbs).background(.mint).font(.subheadline)
        TextField("Fat Per Serving", text: $foodFat).background(.mint).font(.subheadline)
    }
}

struct NameServingSizeAndAmount: View{
    @Binding var name: String
    @Binding var brand: String
    @Binding var servingSize: String
    @Binding var amount: String
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 15).frame(width: 325, height: 50).foregroundColor(.mint)
            TextField("Food Name", text: $name).font(.title).padding()
        }
        TextField("Brand (optional)", text: $brand).background(.mint).font(.subheadline)
        TextField("Serving Size", text: $servingSize).background(.mint).font(.subheadline)
        TextField("# of servings", text: $amount).background(.mint).font(.subheadline)
    }
}

struct CreateCustomFood_Previews: PreviewProvider {
    static var previews: some View {
        CreateCustomFoodView()
    }
}
