//
//  Nutritionix.swift
//  Tracker
//
//  Created by John Johnston on 6/13/22.
//

import SwiftUI


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
            let item_name:String
            let brand_name: String
            let nf_calories:Float
            let nf_total_fat:Float
            let nf_protein:Float
            let nf_total_carbohydrate: Float
            let nf_serving_size_qty : Float
            let nf_serving_size_unit:String
        }
    }
}

class FoodResponse: ObservableObject{
    
    @Published var foodSearchRespnse: [FoodSearchResponse.hit] = []
    
    func sanitizeRequest(unsanitizedFoodString: String) -> String {
        return unsanitizedFoodString.replacingOccurrences(of: " ", with: "_")
    }
    
    func createURL(food: String) -> String{
         return sanitizeRequest(unsanitizedFoodString: "https://api.nutritionix.com/v1_1/search/\(food)?results=0:20&fields=item_name,brand_name,nf_calories,nf_protein,nf_total,nf_total_carbohydrate,nf_total_fat&appId=5c292bc1&appKey=5f695042009fbed8a06d88f654aadcd1")
    }
    
    
    func getResponse(food: String){
        guard let url = URL(string: createURL(food: food)) else {
            print("URL ERROR: ")
            print("THE URL: \(createURL(food: food))")
            fatalError("Mising url")
        }
        
        let urlReq = URLRequest(url: url)
        
        let datatask = URLSession.shared.dataTask(with: urlReq) { [weak self] (data,response,error) in
            if let error = error {
                print("Request Error: ", error)
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return }
                do{
                    let decodeFoodResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        //print(decodeFoodResponse.hits)
                        self?.foodSearchRespnse = decodeFoodResponse.hits
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

