//
//  Nutritionix.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI

struct FoodSearchResponse: Codable{
    
    struct BrandedFood: Codable{
        let food_name: String
        let image: String
        let serving_unit: String
        let nix_brand_id: String
        let brand_name_item_name: String
        let serving_qty: Int
        let nf_calories: Int
        let brand_name: String
        let brand_type: Int
        let nix_item_id: String
    }

    struct SelfFood: Codable{
        let food_name: String
        let serving_unit: String
        let nix_brand_id: String
        let serving_qty: Int
        let nf_calories: Int
        let brand_name: String
        let uuid: String
        let nix_item_id: String
    }

    struct CommonFood: Codable{
        let foodname: String
        let image: String
        let tag_id: String
        let tag_name : String
    }
    
    
    //let id = UUID()
    /*let brandedFoods : [BrandedFood]
    let selfFoods: [SelfFood]
    let commonFoods: [CommonFood]*/
}

class FoodResponse: ObservableObject{
    @Published var foodResponse: FoodSearchResponse = FoodSearchResponse()
    
    func getResponse(){
        guard let url = URL(string: "https://trackapi.nutritionix.com/v2/search/instant?query=apple?") else { fatalError("Mising url")}
        
        let urlReq = URLRequest(url: url)
        
        let datatask = URLSession.shared.dataTask(with: urlReq) { (data,response,error) in
            if let error = error {
                print("Request Error: ", error)
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return }
                DispatchQueue.main.async {
                    do{
                        let decodeFoodResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
                        self.foodResponse = decodeFoodResponse
                    } catch let error{
                        print("Error Decoding: ", error)
                    }
                }
            }
        }
        
        datatask.resume()
    }
}

