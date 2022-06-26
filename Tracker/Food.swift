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
    let brand: String
    let servingSize: String
    var numOfServ: Float = 1
    let calories: Float
    let protein: Float
    let carbs: Float
    let fat: Float
    
}

