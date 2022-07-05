//
//  AddFoodView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

struct AddFoodView: View {
    
    //This means you expect an enviorment variable to be passed but do not create one
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    @StateObject var hits = FoodResponse()
    
    @State var searchFood = ""
    
    @State var searching = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                SearchBar(searchFood: $searchFood, searching: $searching, hits: hits)
                    .navigationTitle(searching ? "Searching Food" : (searchFood.isEmpty ? "Search A Food" : searchFood))
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            NavigationLink(destination: {
                                CreateCustomFoodView()
                            }, label: {
                                Text("Create Food")
                            })
                        })
                    }
            }
            List{
                if !hits.foodSearchRespnse.isEmpty{
                    ForEach(hits.foodSearchRespnse, id: \.self){ hit in
                        let tempFood = Food(name: hit.fields.item_name, brand: hit.fields.brand_name, servingSize: hit.fields.nf_serving_size_unit ?? "", calories: hit.fields.nf_calories ?? 0, protein: hit.fields.nf_protein ?? 0, carbs: hit.fields.nf_total_carbohydrate ?? 0, fat: hit.fields.nf_total_fat ?? 0)
                        AddFoodRow(food: tempFood)
                    }
                }else if searchFood != "" && !searching{
                    Text("No Results for \(searchFood)")
                }
            }
        }
    }
}
    


struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        //should update the previews when creating an enviorment object
        AddFoodView().environmentObject(FoodEnvVar())
    }
}

struct SearchBar: View {
    @Binding var searchFood: String
    @Binding var searching: Bool
    @ObservedObject var hits: FoodResponse
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.mint)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Food..", text: $searchFood) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                }.onSubmit {
                    withAnimation{
                        searching = false
                    }
                    hits.getResponse(food: searchFood, isQRCode: false)
                }
                Button(action: {
                    if searchFood != ""{
                        searchFood = ""
                        withAnimation{
                            searching = false
                        }
                    }
                }, label: {
                    Image(systemName: "delete.left")
                        .foregroundColor(.gray)
                }).padding()
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
