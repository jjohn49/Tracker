//
//  Food.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//
import Foundation
//import SwiftUI

//make identifiable so we can throw it in a for loop for the list
//making Food consorm to codable inorder to store it in NSUserDefaults
//Using JSON
struct Food: Identifiable, Codable {
    //id is necessary for structures that conform to Identifiable
    var id = UUID()
    let name: String
    let servingSize: String
    var numOfServ: Int = 1
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    
}


//will be deleted once I get the api to work
//Api I want to use: https://www.nutritionix.com/
struct FoodList {
    static let list = [
        Food(name: "chicken", servingSize: "1 oz", calories: 150, protein: 30, carbs: 0, fat: 2),
        Food(name: "banana", servingSize: "1 medium sized banana", calories: 100, protein: 0, carbs: 25, fat: 0),
        Food(name: "random", servingSize: "infinity", calories: 2, protein: 2, carbs: 2, fat: 2)
    ]
}
