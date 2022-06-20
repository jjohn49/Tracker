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
    
    var foodInList: [Food] = FoodList.list
    var body: some View {
        VStack{
            //need the id stuff because it is a custom structure
            //this takes everything in foodlist and puts it in the list
            /*List(foodInList, id: \.id) { food in
                VStack{
                    NavigationLink(destination: FoodDetail(food: food).navigationTitle(food.name), label: {
                        Text(food.name)
                    })
                        .padding()
                }
            }*/
            
            //Add a search bar that takes the user input and sends it to the api
            
            VStack(alignment: .leading) {
                SearchBar(searchFood: $searchFood, searching: $searching, hits: hits)
                    .navigationTitle(searching ? "Searching Food" : (searchFood.isEmpty ? "Search A Food" : searchFood))
                    .toolbar{
                        if searching {
                            Button("Cancel") {
                                searchFood = ""
                                withAnimation{
                                    searching = false
                                }
                            }
                        }
                    }
            }
            List{
                ForEach(hits.foodSearchRespnse, id: \.self){ hit in
                    let tempFood = Food(name: hit.fields.item_name, servingSize: hit.fields.nf_serving_size_unit, calories: Int(hit.fields.nf_calories), protein: Int(hit.fields.nf_protein), carbs: Int(hit.fields.nf_total_carbohydrate), fat: Int(hit.fields.nf_total_fat))
                    AddFoodRow(food: tempFood)
                }
            }/*.onAppear {
                print("Did this start?")
                hits.getResponse()
                print("ended")
            }*/
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
                    hits.getResponse(food: searchFood)
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
