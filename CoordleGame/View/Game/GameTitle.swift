//
//  GameTitle.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct TitleView: View {
    
    @Binding var cardShown: Bool
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        
        switch model.gameType {
        case .Daily:
            DailyTitleView()
        case .Classic:
            GameTitleView(cardShown: $cardShown, data: classicLevels[model.level.index()])
        case .Multiplayer:
            DailyTitleView()
        case .Speed:
            DailyTitleView()
        }
        
    }
}

struct DailyTitleView: View {
    
    let lightGreen = Color(UIColor(red: 131/255, green: 212/255, blue: 116/255, alpha: 1.0))
    let darkGreen = Color(UIColor(red: 44/255, green: 182/255, blue: 44/255, alpha: 1.0))
    
    var body: some View {
        
        Text("Daily \nWordle")
            .font(.system(size: 22))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(5)
            .padding(.horizontal, 15)
            .multilineTextAlignment(.center)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [lightGreen, darkGreen]), startPoint: .topLeading, endPoint: .bottomTrailing))
            )
    }
}

struct GameTitle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
        
            DailyTitleView()
            GameTitleView(cardShown: .constant(false), data: classicLevels[1])
        }
    }
}

struct GameTitleView: View {
    
    @Binding var cardShown: Bool
    @State var hueRotate = false
    var data: GameTitle
    var gradient = Gradient(colors: [Color.green, Color.yellowC, Color.orangeC, Color.redC])
        
    var body: some View {
        
        VStack(spacing: 5) {
            
            HStack(spacing: 5) {
                
                Text("STREAK")
                .font(.system(size: 18))
                .foregroundColor(.white)
                
                Text("12")
                .font(.system(size: 22))
                .fontWeight(.bold)
                .foregroundColor(.white)
                
            }.padding(.vertical, 3)
            .padding(.horizontal, 15)
            .background(
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray.opacity(0.8))
            
            )
            .frame(maxHeight: .infinity)
            
            Button(action: {
                withAnimation(Animation.easeOut(duration: 0.3)) {
                    cardShown.toggle()
                }
            }) {
            
            HStack(spacing: 5) {
            
                Text(data.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(5)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity)
                .background(
                    
                    GameTitleBackground(random: data.title == "Random", color: data.color)
                        
                )
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
                    .rotationEffect(cardShown ? .init(degrees: 180) : .zero)
                    .padding(5)
                    .padding(.horizontal, 2)
                    .frame(maxHeight: .infinity)
                    .background(
                        
                        GameTitleBackground(random: data.title == "Random", color: data.color)
                    )
                
            }
            .frame(maxHeight: .infinity)
            .shadow(color: .gray, radius: 3, x: 2, y: 3)
                
            }
            
        }
        .frame(maxHeight: 70)
        .onAppear {
            if data.title == "Random" {
                withAnimation(Animation.easeInOut.speed(0.1).repeatForever()) {
                    hueRotate.toggle()
                }
            }
        }
        
    }

}

struct GameTitleBackground: View {
    
    @State var hueRotate = false
    var random: Bool
    var gradient = Gradient(colors: [Color.green, Color.yellowC, Color.orangeC, Color.redC])
    var color: Color
        
    var body: some View {
        
        if random {

        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .hueRotation(.degrees(random ? (hueRotate ? -400 : .pi * 300) : 0))
            .onAppear {
                withAnimation(Animation.easeInOut.speed(0.1).repeatForever()) {
                    hueRotate.toggle()
                
                }
            }
            
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
        }
        
    }

}


//
//struct TimerGameTitleView: View {
//
//    @State private var isTimerRunning = false
//    @State private var startTime =  Date()
//    @State private var timerString = "00:00"
//
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var data: GameTitle
//
//    var body: some View {
//
//        ZStack(alignment: .bottomTrailing) {
//
//            Text(data.title)
//            .font(.system(size: 20))
//            .fontWeight(.semibold)
//            .foregroundColor(.white)
//            .padding(5)
//            .padding(.horizontal, 10)
//            .background(
//
//                Capsule()
//                    .fill(data.color)
//
//            )
//
//            Text(timerString)
//                .font(.system(size: 15))
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//                .padding(4)
//                .padding(.horizontal, 5)
//                .background(
//
//                    Capsule()
//                        .fill(data.color2)
//
//                )
//                .offset(x: data.offsetX, y: data.offsetY)
//
//        }.onReceive(timer) { _ in
//            if self.isTimerRunning {
//                timerString = Date().passedTime(from: startTime)
//            }
//        }
//        .onAppear() {
//            if !isTimerRunning {
//
//                timerString = "00:00"
//                startTime = Date()
//            }
//
//            isTimerRunning.toggle()
//        }
//    }
//
//}


//struct GameTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        GameTitleView(color: Color.red, title: "Classic", dropText: "5")
//    }
//}
