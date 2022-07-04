//
//  LiftGoalView.swift
//  Tracker
//
//  Created by John Johnston on 7/4/22.
//

import SwiftUI

struct Goal{
    let name: String
    let weight: Int
    let deadline: Date
    let description: String?
}

struct LiftGoalView: View {
    @State var popUp: Bool = false
    @State var list: [Goal] = []
    var body: some View {
        if list.isEmpty{
            VStack {
                Text("No Lifting Goals yet")
                Button(action: {
                    popUp.toggle()
                }, label: {
                    Text("Create Lifting Goal")
                }).popover(isPresented: $popUp, content: {
                    AddLiftGoal(popUp: $popUp)
                })
            }
           
        }else{
            
        }
    }
}

struct AddLiftGoal: View{
    @Binding var popUp: Bool
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
                popUp = false
                //append the new goal to the list
            }, label: {
                Text("Add Goal")
            })
        }
    }
}

struct LiftGoalView_Previews: PreviewProvider {
    static var previews: some View {
        LiftGoalView()
        //AddLiftGoal()
    }
}
