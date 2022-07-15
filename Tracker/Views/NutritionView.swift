//
//  NutritionView.swift
//  Tracker
//
//  Created by John Johnston on 7/2/22.
//

import SwiftUI



struct RainbowView: View{
    let calPercentage: Float
    let proPercentage: Float
    let carbPercentage: Float
    let fatPercentage: Float
    
    
    var body: some View{

        
        ZStack{
            ProgressView("", value:  calPercentage).progressViewStyle(ArcProgressViewStyle(lineWidth: 50, color: .blue)).frame(width: 325)
            
            ProgressView("", value: proPercentage).progressViewStyle(ArcProgressViewStyle(lineWidth: 30,color: Color("Forest"))).frame(width: 225)
            
            ProgressView("", value: carbPercentage).progressViewStyle(ArcProgressViewStyle(lineWidth: 30, color: .yellow)).frame(width: 140)
            
            ProgressView("", value: fatPercentage).progressViewStyle(ArcProgressViewStyle(lineWidth: 30, color: .red)).frame(width: 60)
        }
        
    }
}


struct NutritionView: View {
    
    //maybe make these enviorment variables so that they can be changed by multiple views
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
    
    
    //created this because i don't want to modify foodEnvVar.Date
    @State var selecteddDate: Date
    
    var body: some View {
        NavigationView {
            VStack{
                //this date picker will allow you to access the data from other days
                //Text(String(foodEnvVar.isItANewDay()))
                Spacer()
                DatePicker("", selection: $foodEnvVar.date, displayedComponents: [.date])
                    .frame(alignment: .center)
                RainbowView(calPercentage: foodEnvVar.totalCaloriesConsumedInADay/foodEnvVar.totalCaloriesAllowedInADat, proPercentage: foodEnvVar.totalProteinConsumedInADay/foodEnvVar.proteinGoal, carbPercentage: foodEnvVar.totalCarbsConsumedInADay/foodEnvVar.carbGoal, fatPercentage: foodEnvVar.totalFatConsumedInADay/foodEnvVar.fatGoal)
                
                
                VStack{
                    Text("Calories left: " + String(format: "%.0f", foodEnvVar.totalCaloriesAllowedInADat - foodEnvVar.totalCaloriesConsumedInADay)).foregroundColor(.blue).bold().font(.title2)
                    Text("\(foodEnvVar.totalCaloriesConsumedInADay)")
                    Text("Protein left: " + String(format: "%.0f",  foodEnvVar.proteinGoal - foodEnvVar.totalProteinConsumedInADay)).foregroundColor(Color("Forest")).bold().font(.title2)
                    Text("\(foodEnvVar.totalProteinConsumedInADay)")
                    Text("Carbs left: " + String(format: "%.0f", foodEnvVar.carbGoal - foodEnvVar.totalCarbsConsumedInADay)).foregroundColor(.yellow).bold().font(.title2)
                    Text("\(foodEnvVar.totalCarbsConsumedInADay)")
                    Text("Fat left: " + String(format: "%.0f", foodEnvVar.fatGoal - foodEnvVar.totalFatConsumedInADay)).foregroundColor(.red).bold().font(.title2)
                    Text("\(foodEnvVar.totalFatConsumedInADay)")
                }.padding()
                
                Spacer(minLength: 60)
            }
            .navigationTitle("Macros").padding().background(.mint).toolbar(content: {
                ToolbarItem(content: {
                    Button(action: {
                        //FORCE RESET
                        //ONLY FOR DEBUGGING
                        foodEnvVar.newDay()
                    }, label: {
                        Text("Reset")
                    })
                })
            })
        }
    }
}


struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView(selecteddDate: FoodEnvVar().date).environmentObject(FoodEnvVar())
    }
}
