//
//  LiftView.swift
//  Tracker
//
//  Created by John Johnston on 6/30/22.
//

struct Lift: Identifiable{
    let id = UUID()
    let name: String
    let weight: Int
    let weightMeasurement: String
    let reps: Int
    let sets: Int
}

import SwiftUI

struct LiftView: View {
    @State var prList: [Lift] = []
    var body: some View {
        NavigationView {
            if !prList.isEmpty{
                PRList(prList: $prList)
                    .navigationTitle("Lifts")
                    .toolbar{
                        ToolbarItem(content: {
                            NavigationLink(destination: {
                                addPR(prList: $prList)
                            }, label: {
                                Label("", systemImage: "plus")
                            })
                        })
                    }
            }else{
                VStack {
                    Text("No lifts yet").font(.title2)
                        .navigationTitle("Lifts")
                    NavigationLink(destination: {
                        addPR(prList: $prList)
                                    }, label: {
                                        Text("Add a PR").padding()
                                    }).background(.tint).foregroundColor(.white).cornerRadius(10)
                }
                
            }
            
        }
    }
}

struct addPR: View{
    @Binding var prList: [Lift]
    @State var name: String = ""
    @State var weight: Int = 0
    @State var reps: Int = 0
    @State var sets: Int = 0
    @State var inKG: Bool = false
    var body: some View{
        Form{
            TextField("Name of Lift", text: $name)
            Section(header: Text("Weight")){
                HStack {
                    Text("Weight:")
                    Spacer(minLength: 155).padding()
                    TextField("", value: $weight, formatter: NumberFormatter()).keyboardType(.numberPad)
                }
                Toggle("in \(inKG ? "kg" :  "lb" )", isOn: $inKG)
            }
            Section(header: Text("Reps and Sets")){
                HStack{
                    Text("reps: \(reps)")
                    Stepper{
                        Text("")
                    } onIncrement: {
                        reps += 1
                    } onDecrement: {
                        reps -= 1
                    }
                }
                HStack{
                    Text("sets: \(sets)")
                    Stepper{
                        Text("")
                    } onIncrement: {
                        sets += 1
                    } onDecrement: {
                        sets -= 1
                    }
                }
            }
            
            Button(action: {
                let newLift = Lift(name: name, weight: weight, weightMeasurement: inKG ? "kg" : "lb", reps: reps, sets: sets)
                if !name.isEmpty && weight > 0 && reps > 0 && sets > 0{
                    if !CheckIfExcerciseWithSameRepsOrSetsExists(newPR: newLift) {
                        prList.append(newLift)
                    }
                    
                }
            }, label: {
                Text("Add PR")
            })
            .navigationTitle("Add PR")
        }
        
    }
    
    func CheckIfExcerciseWithSameRepsOrSetsExists(newPR: Lift) -> Bool{
        for (index, pr) in prList.enumerated(){
            if pr.name == newPR.name && pr.weight == newPR.weight && (pr.sets == newPR.sets || pr.reps == newPR.reps){
                prList[index] = newPR
                return true
            }
        }
        return false
    }
}

struct PRList: View {
    @Binding var prList: [Lift]
    var body: some View{
        List{
            ForEach(prList) { pr in
                PRRow(pr: pr)
            }
        }
    }
}

struct PRRow: View{
    var pr: Lift
    var body: some View{
        VStack{
            Text(pr.name).font(.title).bold().padding()
            Text("\(pr.weight) \(pr.weightMeasurement) for \(pr.sets) sets of \(pr.reps)")
        }
    }
}

struct LiftView_Previews: PreviewProvider {
    static var previews: some View {
        LiftView()
    }
}
