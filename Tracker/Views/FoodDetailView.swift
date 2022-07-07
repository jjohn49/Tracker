//
//  FoodDetail.swift
//  Tracker
//
//  Created by John Johnston on 6/9/22.
//

import SwiftUI

struct FoodDetailView: View {
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    @State var food: Food
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var body: some View {
        VStack{
            Text("Serving Size \(food.servingSizeQty) \(food.prefferedUnit)" ).font(.title).bold().padding()
            Text("Brand: \(food.brand)")
            HStack{
                Text("Amount Consumed:").padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)).font(.title3)
                ZStack {
                    RoundedRectangle(cornerRadius: 50).frame(width: 100, height: 50).padding(EdgeInsets(top: 1, leading: 10, bottom: 1, trailing: 10)).foregroundColor(.blue)
                    TextField(String(food.numOfServ),value: $food.numOfServ, formatter: formatter).padding(EdgeInsets(top: 1, leading: 10, bottom: 1, trailing: 10)).frame(width: 100, height: 70, alignment: .trailing).foregroundColor(.white)
                }
                
                Picker("Picker",selection: $food.unitOfMeasurement){
                    if food.prefferedUnit == "g" || food.prefferedUnit == "oz"{
                        Text("g").foregroundColor(.white)
                        Text("oz")
                    }else if food.prefferedUnit == "fl oz" || food.prefferedUnit == "ml" || food.prefferedUnit == "cup"{
                        Text("fl oz")
                        Text("ml")
                        Text("cup")
                    }else{
                        Text(food.prefferedUnit)
                    }
                }.pickerStyle(MenuPickerStyle()).frame(width: 20).onSubmit({
                    //code that calculates the change in macros from switching servings
                    if food.prefferedUnit == "g" && food.unitOfMeasurement == "oz"{
                        food.calories = food.calories / 28.3495
                        food.protein = food.protein / 28.3495
                        food.carbs = food.carbs / 28.3495
                        food.fat = food.fat / 28.3495
                    }
                })
            }.padding()
            HStack{
                Text("Cal:\n" + String(food.calories * food.numOfServ)).padding()
                Text("Pro:\n" + String(food.protein * food.numOfServ)).padding()
                Text("Carb:\n" + String(food.carbs * food.numOfServ)).padding()
                Text("Fat:\n" + String(food.fat * food.numOfServ)).padding()
            }.background(.gray).cornerRadius(10)
            Button(action: {
                foodEnvVar.updateFoodEnvVars(food: food)
                //print("Console is working")
            }, label: {
                Text("Add \(food.servingSizeQty) \(food.unitOfMeasurement) of \(food.name) To The Food Consumed List").padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 50))
            }).background(.tint).foregroundColor(.white).cornerRadius(10).padding()
        }.padding()
            .navigationTitle(food.name)
    }
}
struct FoodDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NavigationView {
            FoodDetailView(food: Food(name: "Pizza", brand: "brand", servingSizeQty: 1, numOfServ: 0, prefferedUnit: "slice" , unitOfMeasurement: "g" ,calories: 0, protein: 0, carbs: 0, fat: 0))
        }
    }
}


