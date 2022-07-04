//
//  LiftGoalView.swift
//  Tracker
//
//  Created by John Johnston on 7/4/22.
//

import SwiftUI

struct Goal: Identifiable{
    let id = UUID()
    let name: String
    let weight: Int
    let deadline: Date
    let description: String?
}

struct LiftGoalView: View {
    
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    /*@Binding var popUp: Bool
    //this is temporary till I decide whether I want to store this in defaults, core data, or some other place
    @Binding var list: [Goal]*/
    var body: some View {
        if foodEnvVar.liftGoals.isEmpty{
            VStack {
                Text("No Lifting Goals yet")
                Button(action: {
                    foodEnvVar.popUp.toggle()
                }, label: {
                    Text("Create Lifting Goal")
                }).popover(isPresented: $foodEnvVar.popUp, content: {
                    AddLiftGoal()
                })
            }
        }else{
            List{
                Text("Lift Goals")
                ForEach(foodEnvVar.liftGoals){ goal in
                    VStack{
                        Text("\(goal.name)")
                    }
                }
            }
        }
    }
}

struct AddLiftGoal: View{
    @EnvironmentObject var foodEnvVar: FoodEnvVar
    @State var name: String = ""
    @State var weightStr: String = ""
    @State var weightInt: Int = 0
    @State var deadline: Date = Date()
    @State var showDescription: Bool = false
    @State var description: String = ""
    var body: some View{
        Form{
            Section(header: Text("Name"), content: {
                TextField("Name For the Excercise", text: $name)
            })
            
            Section(header: Text("Goal"), content: {
                TextField("Target Weight", text: $weightStr).keyboardType(.numberPad).onSubmit {
                    if weightStr != "" {
                        weightInt = Int(weightStr)!
                    }
                }
            })
            
            Section(header: Text("Time Frame"), content: {
                DatePicker("Deadline:", selection: $deadline)
            })
            
            Section(header: Text("Description"), content: {
                Toggle("Show Description", isOn: $showDescription)
                if showDescription{
                    TextEditor(text: $description).frame(width: 300, height: 200)
                }
            })
            
            Button(action: {
                foodEnvVar.popUp = false
                //append the new goal to the list
                foodEnvVar.liftGoals.append(Goal(name: name, weight: weightInt, deadline: deadline, description: description))
            }, label: {
                Text("Add Goal")
            })
        }
    }
}

struct s: View{
    var body: some View{
        Text("Hello")
    }
}

struct LiftGoalView_Previews: PreviewProvider {
    @State var b: Bool = false
    static var previews: some View {
        //LiftGoalView(popUp: $b)
        //AddLiftGoal()
        s()
    }
}
