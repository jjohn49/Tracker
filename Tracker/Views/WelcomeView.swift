//
//  WelcomeView.swift
//  Tracker
//
//  Created by John Johnston on 6/7/22.
//

import SwiftUI

//creates the enviorment variable that can be shared throughout views
// all enviorment variables have to conform to the OBServableObject class

struct WelcomeView: View {
    
    @StateObject var foodEnvVar = FoodEnvVar()
    
    
    var body: some View {
        TabView{
            if !foodEnvVar.setPreferences {
                SetPreferencesView()
                //create a setPreferencesView
                //print("Set preferences is false")
                //foodEnvVar.setPreferences.toggle()
            }else{
                NutritionView(selecteddDate: foodEnvVar.date)
                    .tabItem{
                        Label("Macros", systemImage: "leaf.circle")
                    }
                GoalsView()
                    .tabItem{
                        Label("Goals", systemImage: "flame.circle")
                    }
                FoodConsumedListView()
                    .tabItem{
                        Label("Food", systemImage: "pills.circle")
                    }
                LiftView()
                    .tabItem{
                        Label("Lift", systemImage: "bolt.circle")
                    }
            }
            //put the variable foodListConsumed which is part of the custom class so that
            //all views within the navigation view have access to the variable
        }.environmentObject(foodEnvVar)
            .onAppear{
            foodEnvVar.fetchFromDefaults()
            foodEnvVar.isItANewDay()
            //print(foodEnvVar.date)
        }
    }

}

struct GoalsView: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    
    var body: some View{
        NavigationView{
            List {
                MacroGoalView()
                .navigationTitle("Goals")
                .toolbar{
                    ToolbarItem(content: {
                        Button(action: {
                            foodEnvVar.setPreferences.toggle()
                        }, label: {
                            Label("Set Goals", systemImage: "brain")
                        })
                    })
            }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            .previewInterfaceOrientation(.portrait)        }
    }
}



