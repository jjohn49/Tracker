//
//  Food.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct Food {
    let name: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
}


//will be deleted once I get the api to work
//Api I want to use: https://www.nutritionix.com/
struct FoodList {
    var list = [
        Food(name: "chicken", calories: 150, protein: 30, carbs: 0, fat: 2),
        Food(name: "banana", calories: 100, protein: 0, carbs: 25, fat: 0),
        Food(name: "random", calories: 2, protein: 2, carbs: 2, fat: 2)
    ]
}
