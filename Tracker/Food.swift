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
    var numOfServ: Int = 1
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    
}

