//
//  ProgressViewStyles.swift
//  Tracker
//
//  Created by John Johnston on 6/24/22.
//

import SwiftUI

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 250, height: 28)
                .foregroundColor(.blue)
                .overlay(Color.black.opacity(0.5)).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(configuration.fractionCompleted != 1 ? .green : .red)
        }
        .padding()
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

struct ArcProgressViewStyle: ProgressViewStyle {
    let lineWidth: CGFloat
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Arc(startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false).stroke(color.opacity(0.5) , lineWidth: lineWidth)
            Arc(startAngle: .degrees(180), endAngle: .degrees(((configuration.fractionCompleted ?? 0) - 1) * 180), clockwise: false).stroke(color , lineWidth: lineWidth)
        }
    }
}


struct CircleProgressViewStyle: ProgressViewStyle{
    let lineWidth: CGFloat
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle().stroke(color.opacity(0.5),lineWidth: lineWidth)
            Arc(startAngle: .degrees(180), endAngle: .degrees((configuration.fractionCompleted ?? 0) * 360 + 180), clockwise: false).stroke(color, lineWidth: lineWidth)
        }
        
    }
}
