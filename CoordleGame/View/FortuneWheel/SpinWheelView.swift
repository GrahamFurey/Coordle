//
//  SpinWheel.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI

struct SpinWheelPointer: View {
    var body: some View {
        
        ZStack {
            
            Image("pointer")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.textColor)
        
            Image("pointer")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foreground(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .gold1, location: 0),
                                                                      Gradient.Stop(color: .gold1, location: 0.5),
                                                                      Gradient.Stop(color: .gold2, location: 0.5),
                                                                      Gradient.Stop(color: .gold2, location: 1.0)]), startPoint: .leading, endPoint: .trailing))
                
            
            Circle()
                .fill(Color.background)
                .frame(width: 10, height: 10)
            
        }
        
    }
}

struct SpinWheelBolt: View {
    
    let outside = Color(UIColor(red: 254/255, green: 181/255, blue: 1/255, alpha: 1.0))
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [outside, Color.gold2]),
                                     startPoint: .bottom, endPoint: .top))
                .frame(width: 70, height: 70)
            
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [outside, Color.gold2]),
                                       startPoint: .bottom, endPoint: .top))
                .opacity(0.5)
                .background(Circle().fill(Color.background))
                .frame(width: 40, height: 40)
            
            Circle()
                .fill(Color.background)
                .frame(width: 20, height: 20)
        }
        .rotationEffect(.degrees(-90))
    }
}

struct SpinWheelCell: Shape {
    
    let startAngle: Double, endAngle: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let alpha = CGFloat(startAngle)
        let center = CGPoint(
            x: rect.midX,
            y: rect.midY
        )
        path.move(to: center)
        path.addLine(
            to: CGPoint(
                x: center.x + cos(alpha) * radius,
                y: center.y + sin(alpha) * radius
            )
        )
        path.addArc(
            center: center, radius: radius,
            startAngle: Angle(radians: startAngle),
            endAngle: Angle(radians: endAngle),
            clockwise: false
        )
        path.closeSubpath()
        return path
    }
}

struct SpinWheelCellView: View {
    var startAngle: Double
    var endAngle: Double
    var index: Int
    
    var body: some View {
        SpinWheelCell(startAngle: startAngle, endAngle: endAngle)
            .fill(LinearGradient(gradient: Gradient(colors: index % 2 == 0 ? [.lightPurple1,.lightPurple2] : [Color.darkPurple1,Color.darkPurple2]),
                                 startPoint: .top, endPoint: .bottom))
    }
}

struct CellOverlay: View {
    var label: String
    var offset: CGSize
    var rotate: Double
    
    var body: some View {
        VStack {
            Image("gem")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(label)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color.white)
        }
        .padding(.top,10)
        .rotationEffect(.degrees(rotate))
        .offset(offset)
        .zIndex(1)
    }
}

struct GiftCellView: View {
    var sA: Double
    var eA: Double
    var body: some View {
        SpinWheelCell(startAngle: sA, endAngle: eA)
            .fill(LinearGradient(gradient: Gradient(colors: [.gold2,.gold1]),
                                 startPoint: .bottom, endPoint: .top))
    }
}

struct GiftOverlay: View {
    var offset: CGSize
    var rotate: Double
    
    var body: some View {
        Image(systemName: "gift.fill")
            .font(.system(size: 30, weight: .bold))
            .foreground(LinearGradient(gradient: Gradient(colors: [.gold2,.gold1]),
                                             startPoint: .top, endPoint: .bottom))
            .padding(6)
            .background(
                Circle()
                    .fill(Color.background)
            )
            .padding(.top,10)
            .rotationEffect(.degrees(rotate))
            .offset(offset)
            .zIndex(1)
    }
}

struct SpinWheelView: View {

    var data: [Double]

    let labels = ["25","50","75","99","75","50","25"]
    private let sliceOffset: Double = -.pi / 2
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ForEach(0..<7) { i in
                    
                    SpinWheelCellView(startAngle: startAngle(for: i), endAngle: endAngle(for: i), index: i + 1)
                        .overlay(CellOverlay(label: labels[i], offset: viewOffset(for: i, in: geo.size), rotate: 22.5 + Double(i*45)))
                    
                }
                
                GiftCellView(sA: startAngle(for: 7), eA: endAngle(for: 7))
                    .overlay(GiftOverlay(offset: viewOffset(for: 7, in: geo.size), rotate: 337.5))
                        
                
            }
            .rotationEffect(.degrees(112.5))
            
        }
    }
    
    private func startAngle(for index: Int) -> Double {
        switch index {
        case 0: return sliceOffset
        default:
            let ratio: Double = data[..<index].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }
    
    private func endAngle(for index: Int) -> Double {
        switch index {
        case data.count - 1: return sliceOffset + 2 * .pi
        default:
            let ratio: Double = data[..<(index + 1)].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }
    
    private func viewOffset(for index: Int, in size: CGSize) -> CGSize {
        let radius = min(size.width, size.height) / 3
        let dataRatio = (2 * data[..<index].reduce(0, +) + data[index]) / (2 * data.reduce(0, +))
        let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)
        return CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }
}
