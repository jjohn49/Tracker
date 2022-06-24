//
//  WelcomeView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

//creates the enviorment variable that can be shared throughout views
// all enviorment variables have to conform to the OBServableObject class
class FoodEnvVar: ObservableObject{
    
    @Published var date = Date()
    @Published var setPreferences: Bool = false
    
    @Published var foodCosumedListVar: [Food] = []
    
    @Published var proteinGoal: Int = 0
    @Published var totalProteinConsumedInADay: Int = 0
    
    @Published var carbGoal: Int = 0
    @Published var totalCarbsConsumedInADay: Int = 0
    
    @Published var fatGoal: Int = 0
    @Published var totalFatConsumedInADay: Int = 0
    
    @Published var totalCaloriesAllowedInADat: Int = 0
    @Published var totalCaloriesConsumedInADay: Int = 0
    
    
    //this method essentially does the calculations of how many calories are consumed from meeting all your macro goals
    //Makes less code in the GoalRows.swift file
    func calcTotalCalsAllowed(){
        if (proteinGoal + carbGoal) * 4 + (fatGoal * 8) != totalCaloriesAllowedInADat{
            totalCaloriesAllowedInADat = 4 * (proteinGoal + carbGoal) + ( 8 * fatGoal)
        }
    }
    
    func dateToStr() -> String{
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        
        return format.string(from: date)
    }
    
    func diffOfTotalCalAndMacros()->Int{
        return totalCaloriesAllowedInADat - 4 * (proteinGoal + carbGoal) + ( 8 * fatGoal)
    }
    
    //checks to see if it is a new day and calls the newDay method
    func isItANewDay(){
        if !Calendar.current.isDateInToday(date){
            newDay()
        }
    }
    
    //makes all the macros consumed today vars = 0 bc its a new day
    func newDay(){
        //send all of the data to the database when that is set up
        date = Date()
        totalCaloriesConsumedInADay = 0
        totalProteinConsumedInADay = 0
        totalCarbsConsumedInADay = 0
        totalFatConsumedInADay = 0
    }
    
    //saves all the food enviorment variables to user defaults
    func saveToDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(setPreferences, forKey: "setPreferences")
        
        //encodes the custom struct to json to save to user defaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(foodCosumedListVar){
            defaults.set(encoded, forKey: "foodConsumedListVar")
        }
        
        defaults.set(proteinGoal, forKey: "proteinGoal")
        defaults.set(totalProteinConsumedInADay, forKey: "totalProteinConsumedInADay")
        defaults.set(carbGoal, forKey: "carbGoal")
        defaults.set(totalCarbsConsumedInADay, forKey: "totalCarbsConsumedInADay")
        defaults.set(fatGoal, forKey: "fatGoal")
        defaults.set(totalFatConsumedInADay, forKey: "totalFatConsumedInADay")
        defaults.set(totalCaloriesAllowedInADat, forKey: "totalCaloriesAllowedInADat")
        defaults.set(totalCaloriesConsumedInADay, forKey: "totalCaloriesConsumedInADay")
    }

    //Fetches data fro m UserDefaults so settings are saved persistently
    func fetchFromDefaults(){
        let defaults = UserDefaults.standard
        setPreferences = defaults.bool(forKey: "setPreferences")
        
        if let encodedFoodList = defaults.object(forKey: "foodConsumedListVar") as? Data {
            let decoder = JSONDecoder()
            if let temp = try? decoder.decode([Food].self, from: encodedFoodList){
                foodCosumedListVar = temp
            }
        }
        
        print(foodCosumedListVar)
        
        proteinGoal = defaults.integer(forKey: "proteinGoal")
        totalProteinConsumedInADay = defaults.integer(forKey: "totalProteinConsumedInADay")
        carbGoal = defaults.integer(forKey: "carbGoal")
        totalCarbsConsumedInADay = defaults.integer(forKey: "totalCarbsConsumedInADay")
        fatGoal = defaults.integer(forKey: "fatGoal")
        totalFatConsumedInADay = defaults.integer(forKey: "totalFatConsumedInADay")
        totalCaloriesAllowedInADat = defaults.integer(forKey: "totalCaloriesAllowedInADat")
        totalCaloriesConsumedInADay = defaults.integer(forKey: "totalCaloriesConsumedInADay")
    }
}

struct WelcomeView: View {
    
    @StateObject var foodEnvVar = FoodEnvVar()
    
    
    var body: some View {
        TabView{
            if !foodEnvVar.setPreferences {
                SetPreferences()
                //create a setPreferencesView
                //print("Set preferences is false")
                //foodEnvVar.setPreferences.toggle()
            }else{
                GoalsView()
                    .tabItem{
                        Label("Goals", systemImage: "flame.circle")
                    }
                NutritionView(caloriesAllowed: foodEnvVar.totalCaloriesAllowedInADat, caloriesConsumed: foodEnvVar.totalCaloriesConsumedInADay, proteinConsumed: foodEnvVar.totalProteinConsumedInADay, carbsConsumed: foodEnvVar.totalCarbsConsumedInADay, fatsConsumed: foodEnvVar.totalFatConsumedInADay)
                    .tabItem{
                        Label("Macros", systemImage: "leaf.circle")
                    }
                foodCosumedView()
                    .tabItem{
                        Label("Food Consumed", systemImage: "pills.circle")
                    }
                AddFoodView()
                    .tabItem{
                        Label("Add Food", systemImage: "cross.circle")
                    }
            }
            
            //put the variable foodListConsumed which is part of the custom class so that
            //all views within the navigation view have access to the variable
        }.environmentObject(foodEnvVar).onAppear{
            foodEnvVar.fetchFromDefaults()
            foodEnvVar.isItANewDay()
        }
    }

}

struct GoalsView: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View{
        NavigationView{
            VStack{
                CalorieGoalRow()
                ProteinGoalRow()
                CarbGoalRow()
                FatGoalRow()
            }
            .navigationTitle("Goals")
            .toolbar{
                ToolbarItem(content: {
                    Button(action: {
                        foodEnvVar.setPreferences.toggle()
                    }, label: {
                        Label("Set Goals", systemImage: "brain")
                    })
                })
            }
        }
    }
}

struct foodCosumedView: View{
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    
    var body: some View{
        NavigationView{
            if !foodEnvVar.foodCosumedListVar.isEmpty{
                List {
                    ForEach(foodEnvVar.foodCosumedListVar) { food in
                        FoodConsumedRow(food: food)
                    }
                    .onDelete { indexSet in
                        let index = indexSet[indexSet.startIndex]
                        let foodToDelete: Food = foodEnvVar.foodCosumedListVar[index]
                        foodEnvVar.foodCosumedListVar.remove(atOffsets: indexSet)
                        foodEnvVar.totalCaloriesConsumedInADay -= foodToDelete.calories * foodToDelete.numOfServ
                        foodEnvVar.totalProteinConsumedInADay -= foodToDelete.protein * foodToDelete.numOfServ
                        foodEnvVar.totalCarbsConsumedInADay -= foodToDelete.carbs * foodToDelete.numOfServ
                        foodEnvVar.totalFatConsumedInADay -= foodToDelete.fat * foodToDelete.numOfServ
                    }
                    .navigationTitle("Food Consumed")
                }
            } else {
                Text("You Haven't Eaten Today")
                    .navigationTitle("No Food")
            }
        }
    }
}

struct NutritionView: View {
    
    //maybe make these enviorment variables so that they can be changed by multiple views
    var caloriesAllowed: Int
    var caloriesConsumed : Int
    
    var proteinConsumed: Int
    var carbsConsumed: Int
    var fatsConsumed: Int
    
    //gets the percetage of hoe many calories you've eaten compared
    //to how much you are alowed to eat in a day
    func getPercentage()->Float{
        return Float(caloriesConsumed)/Float(caloriesAllowed)
    }
    
    var body: some View {
        let caloriesLeft = caloriesAllowed - caloriesConsumed
        NavigationView {
            VStack{
                Text("Calories Left: " + String(caloriesAllowed - caloriesConsumed))
                ProgressView(value: getPercentage())
                    .padding()
                VStack{
                    Text("Protein: " + String(proteinConsumed) + "g")
                    ProgressView(value: 0.5)
                    
                    Text("Carbs: " + String(carbsConsumed) + "g")
                    ProgressView(value: 0.5)
                    
                    Text("Fat: " + String(fatsConsumed) + "g")
                    ProgressView(value: 0.5)
                }
                .padding()
                //add better styling
                .border(.black)
            }
            .padding()
            .navigationTitle("Macros")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            .previewInterfaceOrientation(.portrait)        }
    }
}



