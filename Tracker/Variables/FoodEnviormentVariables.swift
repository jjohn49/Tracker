//
//  FoodEnviormentVariables.swift
//  Tracker
//
//  Created by John Johnston on 6/24/22.
//

import Foundation
import WidgetKit
import HealthKit

class FoodEnvVar: ObservableObject{
    
    @Published var date = Date()
    @Published var setPreferences: Bool = false
    
    @Published var foodCosumedListVar: [Food] = []
    
    @Published var proteinGoal: Float = 0
    @Published var totalProteinConsumedInADay: Float = 0
    
    @Published var carbGoal: Float = 0
    @Published var totalCarbsConsumedInADay: Float = 0
    
    @Published var fatGoal: Float = 0
    @Published var totalFatConsumedInADay: Float = 0
    
    @Published var totalCaloriesAllowedInADat: Float = 0
    @Published var totalCaloriesConsumedInADay: Float = 0
    
    @Published var weight: Float = 0
    
    @Published var popUp: Bool = false
    @Published var liftGoals: [Goal] = []
    
    
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
    
    func dateToStrShortVersion()-> String{
        let format = DateFormatter()
        format.dateStyle = .short
        
        return format.string(from: date)
    }
    
    func diffOfTotalCalAndMacros()->Float{
        return totalCaloriesAllowedInADat - 4 * (proteinGoal + carbGoal) + ( 8 * fatGoal)
    }
    
    //NEED TO FIX ----------------------------------------------------------
    //checks to see if it is a new day and calls the newDay method
    func isItANewDay()-> Bool{
        return !Calendar.current.isDateInToday(date)
    }
    
    //makes all the macros consumed today vars = 0 bc its a new day
    func newDay(){
        //send all of the data to the database when that is set up
        date = Date()
        totalCaloriesConsumedInADay = 0
        totalProteinConsumedInADay = 0
        totalCarbsConsumedInADay = 0
        totalFatConsumedInADay = 0
        foodCosumedListVar = []
        
        saveToDefaults()
    }
    //-------------------------------------------------------------------------
    
    //saves all the food enviorment variables to user defaults
    func saveToDefaults() {
        
        let defaults = UserDefaults(suiteName: "group.com.hugh.Tracker")!
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
        
        defaults.set(date, forKey: "date")
        
        
        //makes the widget update the timeline
        WidgetCenter.shared.reloadAllTimelines()
    }

    //Fetches data fro m UserDefaults so settings are saved persistently
    func fetchFromDefaults(){
        let defaults = UserDefaults(suiteName: "group.com.hugh.Tracker")!
        setPreferences = defaults.bool(forKey: "setPreferences")
        
        if let encodedFoodList = defaults.object(forKey: "foodConsumedListVar") as? Data {
            let decoder = JSONDecoder()
            if let temp = try? decoder.decode([Food].self, from: encodedFoodList){
                foodCosumedListVar = temp
            }
        }
        
        //print(foodCosumedListVar)
        
        proteinGoal = defaults.float(forKey: "proteinGoal")
        totalProteinConsumedInADay = defaults.float(forKey: "totalProteinConsumedInADay")
        carbGoal = defaults.float(forKey: "carbGoal")
        totalCarbsConsumedInADay = defaults.float(forKey: "totalCarbsConsumedInADay")
        fatGoal = defaults.float(forKey: "fatGoal")
        totalFatConsumedInADay = defaults.float(forKey: "totalFatConsumedInADay")
        totalCaloriesAllowedInADat = defaults.float(forKey: "totalCaloriesAllowedInADat")
        totalCaloriesConsumedInADay = defaults.float(forKey: "totalCaloriesConsumedInADay")
        
        if let temp = defaults.object(forKey: "date") as? Date{
            date = temp
        }
    }
    
    func updateFoodEnvVars(food:Food){
        foodCosumedListVar.append(food)
        totalCaloriesConsumedInADay += food.calories * food.numOfServ
        totalProteinConsumedInADay += food.protein * food.numOfServ
        totalCarbsConsumedInADay += food.carbs * food.numOfServ
        totalFatConsumedInADay += food.fat * food.numOfServ
        saveToDefaults()
        saveFoodToHK(food: food)
    }
    
    //works
    func reqFoodPermissionToHK(){
        if !HKHealthStore.isHealthDataAvailable(){
            return
        }
        
        let hk = HKHealthStore()
        
        let types = Set([
            //set for all the hk datatypes that we want to request permission to use
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: .dietaryProtein)!,
            HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!
        ])
        
        hk.requestAuthorization(toShare: types, read: types, completion: { (success, error) in
            if !success{
                fatalError("REQUEST AUTHORIZATION ERROR:" + error!.localizedDescription)
            }
        })
    }
    
    func saveFoodToHK(food: Food){
        if !HKHealthStore.isHealthDataAvailable(){
            return
        }
        
        let hk = HKHealthStore()
        
        hk.save(createArrayOfMacroHKQuantitySamples(), withCompletion: { (success, error) in
            if !success{
                print(error!)
            }
            else{
                print("Saved \(food.name)")
            }
        })
    }
    
    func createArrayOfMacroHKQuantitySamples() -> [HKQuantitySample]{
        return[
            HKQuantitySample(type: .quantityType(forIdentifier: .dietaryEnergyConsumed)!, quantity: HKQuantity(unit: HKUnit.largeCalorie(), doubleValue: Double(totalCaloriesConsumedInADay)), start: Date(), end: Date()),
            HKQuantitySample(type: .quantityType(forIdentifier: .dietaryProtein)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: Double(totalProteinConsumedInADay)), start: Date(), end: Date()),
            HKQuantitySample(type: .quantityType(forIdentifier: .dietaryCarbohydrates)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: Double(totalCarbsConsumedInADay)), start: Date(), end: Date()),
            HKQuantitySample(type: .quantityType(forIdentifier: .dietaryFatTotal)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: Double(totalFatConsumedInADay)), start: Date(), end: Date())
        ]
    }
}
