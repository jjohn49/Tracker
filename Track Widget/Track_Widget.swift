//
//  Track_Widget.swift
//  Track Widget
//
//  Created by John Johnston on 7/8/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> MacroEntry {
        MacroEntry(date: Date(), configuration: ConfigurationIntent(), calorieGoal: 2500, calories: 0, proteinGoal: 200, protein: 0, carbGoal: 225, carb: 0, fatGoal: 100, fat: 0)
    }

    //What you see when you want to add a widget to your home screen
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MacroEntry) -> ()) {
        let entry = MacroEntry(date: Date(), configuration: configuration, calorieGoal: 225, calories: 0, proteinGoal: 200, protein: 0, carbGoal: 225, carb: 0, fatGoal: 100, fat: 0)
        completion(entry)
    }

    //what your app shows when it is actually running
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let defaults = UserDefaults(suiteName: "group.com.hugh.Tracker")
        
        /*var entries: [MacroEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MacroEntry(date: entryDate, configuration: configuration, calorieGoal: (defaults?.float(forKey: "totalCaloriesAllowedInADat"))!, calories: (defaults?.float(forKey: "totalCaloriesConsumedInADay"))!, proteinGoal: (defaults?.float(forKey: "proteinGoal"))!, protein: (defaults?.float(forKey: "totalProteinConsumedInADay"))!, carbGoal: (defaults?.float(forKey: "carbGoal"))!, carb: (defaults?.float(forKey: "totalCarbsConsumedInADay"))!, fatGoal: (defaults?.float(forKey: "fatGoal"))!, fat: (defaults?.float(forKey: "totalFatConsumedInADay"))!)
            entries.append(entry)
        }*/
        
        //Don't need an entire list of entries just need the current one
        //Updates everytime the parent app saves to defaults
        let entry = MacroEntry(date: Date(), configuration: configuration, calorieGoal: (defaults?.float(forKey: "totalCaloriesAllowedInADat"))!, calories: (defaults?.float(forKey: "totalCaloriesConsumedInADay"))!, proteinGoal: (defaults?.float(forKey: "proteinGoal"))!, protein: (defaults?.float(forKey: "totalProteinConsumedInADay"))!, carbGoal: (defaults?.float(forKey: "carbGoal"))!, carb: (defaults?.float(forKey: "totalCarbsConsumedInADay"))!, fatGoal: (defaults?.float(forKey: "fatGoal"))!, fat: (defaults?.float(forKey: "totalFatConsumedInADay"))!)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MacroEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let calorieGoal: Float
    let calories: Float
    
    let proteinGoal: Float
    let protein: Float
    
    let carbGoal: Float
    let carb: Float
    
    let fatGoal: Float
    let fat: Float
}

struct CircleView: View {
    var body: some View{
        Circle().padding()
    }
}

struct Track_WidgetEntryView : View {
    var entry: Provider.Entry

    @State var clicked: Bool = false
    
    var body: some View {
        /*VStack {
            HStack {
                Text("Cal:")
                Text(String(format: "%.0f", entry.calories) + "  /")
                Text(String(format: "%.0f", entry.calorieGoal))
            }
            
            HStack {
                Text("Pro: ")
                Text(String(format: "%.0f", entry.protein) + "  /")
                Text(String(format: "%.0f", entry.proteinGoal))
            }
            
            HStack {
                Text("Crb:")
                Text(String(format: "%.0f", entry.carb) + "  /")
                Text(String(format: "%.0f", entry.carbGoal))
            }
            
            HStack {
                Text("Fat:")
                Text(String(format: "%.0f", entry.fat) + "  /")
                Text(String(format: "%.0f", entry.fatGoal))
            }
        }*/
        
        CircleView()
    }
}

@main
struct Track_Widget: Widget {
    let kind: String = "Track_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Track_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Track_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Track_WidgetEntryView(entry: MacroEntry(date: Date(), configuration: ConfigurationIntent(), calorieGoal: 2500, calories: 0, proteinGoal: 200, protein: 0, carbGoal: 225, carb: 0, fatGoal: 100, fat: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
