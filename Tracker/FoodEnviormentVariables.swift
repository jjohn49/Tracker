//
//  FoodEnviormentVariables.swift
//  Tracker
//
//  Created by John Johnston on 6/24/22.
//

import Foundation

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
        
        //print(foodCosumedListVar)
        
        proteinGoal = defaults.integer(forKey: "proteinGoal")
        totalProteinConsumedInADay = defaults.integer(forKey: "totalProteinConsumedInADay")
        carbGoal = defaults.integer(forKey: "carbGoal")
        totalCarbsConsumedInADay = defaults.integer(forKey: "totalCarbsConsumedInADay")
        fatGoal = defaults.integer(forKey: "fatGoal")
        totalFatConsumedInADay = defaults.integer(forKey: "totalFatConsumedInADay")
        totalCaloriesAllowedInADat = defaults.integer(forKey: "totalCaloriesAllowedInADat")
        totalCaloriesConsumedInADay = defaults.integer(forKey: "totalCaloriesConsumedInADay")
    }
    
    func updateFoodEnvVars(food:Food){
        foodCosumedListVar.append(food)
        totalCaloriesConsumedInADay += food.calories * food.numOfServ
        totalProteinConsumedInADay += food.protein * food.numOfServ
        totalCarbsConsumedInADay += food.carbs * food.numOfServ
        totalFatConsumedInADay += food.fat * food.numOfServ
        saveToDefaults()
    }
}
