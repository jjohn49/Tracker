//
//  Nutritionix.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI
import Foundation


struct FoodSearchResponse: Hashable ,Codable{
    let total_hits: Int
    let max_score: Float
    let hits: [hit]
    
    struct hit: Hashable, Codable{
        let _index: String
        let _type: String
        let _id: String
        let _score: Float
        let fields: Field
        
        struct Field: Hashable, Codable{
            
            var item_id : String? = ""
            var item_name : String? = ""
            var brand_id : String? = ""
            var brand_name : String? = ""
            var item_description : String? = ""
            var updated_at : String? = ""
            var nf_ingredient_statement : String? = ""
            var nf_calories : Float? = 0
            var nf_calories_from_fat: Float? = 0
            var nf_total_fat : Float? = 0
            var nf_saturated_fat : Float? = 0
            var nf_cholesterol : Float? = 0
            var nf_sodium : Float? = 0
            var nf_total_carbohydrate: Float? = 0
            var nf_dietary_fiber: Float? = 0
            var nf_sugars : Float? = 0
            var nf_protein: Float? = 0
            var nf_vitamin_a_dv : Float? = 0
            var nf_vitamin_c_dv : Float? = 0
            var nf_calcium_dv : Float? = 0
            var nf_iron_dv : Float? = 0
            var nf_servings_per_container : Float? = 0
            var nf_serving_size_qty : Float? = 0
            var nf_serving_size_unit : String? = ""
            
            func upcResonse()->[FoodSearchResponse.hit]{
                
                return [FoodSearchResponse.hit(_index: "0", _type: "item", _id: item_id ?? "" , _score: 12, fields: self)]
                
            }
        }
    }
}




class FoodResponse: ObservableObject{
    
    @Published var foodSearchRespnse: [FoodSearchResponse.hit] = []
    
    //strips the input of all " " so an error doesn't occur
    func sanitizeRequest(unsanitizedFoodString: String) -> String {
        return unsanitizedFoodString.replacingOccurrences(of: " ", with: "_")
    }
    
    //creates the url for api request (GET) and differentiates between we are sending a upc code of text
    func createURL(food: String, isUPCCode: Bool) -> String{
        if !isUPCCode{
            return sanitizeRequest(unsanitizedFoodString: "https://api.nutritionix.com/v1_1/search/\(food)?results=0:20&fields=item_name,brand_name,nf_calories,nf_protein,nf_total,nf_total_carbohydrate,nf_total_fat")
        }else{
            return sanitizeRequest(unsanitizedFoodString: "https://api.nutritionix.com/v1_1/item?upc=\(food)&appId=5c292bc1&appKey=5f695042009fbed8a06d88f654aadcd1")
        }
    }
    
    
    func getResponse(food: String, isUPCCode: Bool){
        guard let url = URL(string: createURL(food: food, isUPCCode: isUPCCode)) else {
            print("URL ERROR: ")
            print("THE URL: \(createURL(food: food, isUPCCode: isUPCCode))")
            fatalError("Mising url")
        }
        
        //this is to make the code look cleaner
        let headers = [
            "appId":"5c292bc1",
            "appKey":"5f695042009fbed8a06d88f654aadcd1"
        ]
        
        print(url)
        var urlReq = URLRequest(url: url)
        //makes the hhtp request use get b/c thats what the api wants
        urlReq.httpMethod = "GET"
        //attaches headers to the url (makes it look cleaner) basically appends it to the back of the url
        urlReq.allHTTPHeaderFields = headers
        let datatask = URLSession.shared.dataTask(with: urlReq) { [weak self] (data,response,error) in
            if let error = error {
                print("Request Error: ", error)
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return }
                
                do{
                    //this is to differentiate when it is from being searced or not
                    if !isUPCCode{
                        let decodeFoodResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
                        DispatchQueue.main.async {
                            //print(decodeFoodResponse.hits)
                            self?.foodSearchRespnse = decodeFoodResponse.hits
                        }
                    //this will tie into the upc view
                    }else {
                        let decodeFoodResponse = try JSONDecoder().decode(FoodSearchResponse.hit.Field.self, from: data)
                        print(decodeFoodResponse)
                        self?.foodSearchRespnse = decodeFoodResponse.upcResonse()
                    }
                } catch let error{
                    //this gets executed when the url is created but nothing matches the url
                    
                    print("Error Decoding: ", error)
                    self?.foodSearchRespnse = []
                }
                
            }
        }
        datatask.resume()
    }
    
   
}


