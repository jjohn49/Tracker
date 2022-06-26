//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetail: View {
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    @State var food: Food
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var body: some View {
        VStack{
            Text("Serving Size: " + food.servingSize).font(.title).bold().padding()
            Text("Brand: \(food.brand)")
            HStack{
                Text("Number of servings").padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)).font(.title3)
                ZStack {
                    RoundedRectangle(cornerRadius: 50).frame(width: 50, height: 50).padding(EdgeInsets(top: 1, leading: 10, bottom: 1, trailing: 10)).foregroundColor(.blue)
                    TextField(String(food.numOfServ),value: $food.numOfServ, formatter: formatter).padding(EdgeInsets(top: 1, leading: 10, bottom: 1, trailing: 10)).frame(width: 40, height: 70).foregroundColor(.white)
                }
            }.padding()
            HStack{
                Text("Calories: " + String(food.calories * food.numOfServ)).padding()
                Text("Protein: " + String(food.protein * food.numOfServ)).padding()
                Text("Carbs: " + String(food.carbs * food.numOfServ)).padding()
                Text("Fat:    " + String(food.fat * food.numOfServ)).padding()
            }.background(.gray).cornerRadius(10)
            Button(action: {
                foodEnvVar.updateFoodEnvVars(food: food)
            }, label: {
                Text("Add " + food.name + " To The Food Consumed List").padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 50))
            }).background(.tint).foregroundColor(.white).cornerRadius(10).padding()
        }.padding()
    }
}
struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: Food(name: "", brand: "", servingSize: "", numOfServ: 0, calories: 0, protein: 0, carbs: 0, fat: 0))
    }
}


