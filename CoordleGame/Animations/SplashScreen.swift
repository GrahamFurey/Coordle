//
//  SplashScreen.swift
//  Coordle
//
//  Created by Graham Furey on 3/26/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var startAnimation = false
    @State var boxAnimation = false
    @State var endAnimation = false
    @State var endAnimation2 = false
    @State var startLetters = false
    @State var opacity: CGFloat = 1.0
    
    @Binding var fullEnd: Bool
    @EnvironmentObject var system: SystemFunctions
    
    var body: some View {
        
        ZStack {
            
            Color.red
            
            ZStack {
                
                SplashShape()
                    .trim(from: 0, to: startAnimation ? 1 : 0)
                    .stroke(Color.white, style:
                                StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                
                SplashBox()
                    .trim(from: 0, to: boxAnimation ? 1 : 0)
                    .stroke(Color.white, style:
                                StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                
                
            }.frame(width: 220, height: 130)
            .offset(x: endAnimation2 ? -600 : 0)
            .scaleEffect(endAnimation ? 0.2 : 0.9)
            
            HStack() {
                
                OShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 35)
                    .animation(!fullEnd ? getAnimation(3) : exitAni())
                
                OShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 35)
                    .animation(!fullEnd ? getAnimation(3.1) : exitAni())
            
                RShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 30)
                    .animation(!fullEnd ? getAnimation(3.2) : exitAni())
                
                DShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 30)
                    .animation(!fullEnd ? getAnimation(3.3) : exitAni())
                
                LShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 30)
                    .animation(!fullEnd ? getAnimation(3.4) : exitAni())
                
                EShape()
                    .trim(from: 0, to: startLetters ? 1 : 0)
                    .stroke(Color.white, style:
                            StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .scaleEffect(0.2)
                    .frame(maxWidth: 20)
                    .animation(!fullEnd ? getAnimation(3.5) : exitAni())
               
            }.offset(x: 35, y: -60)
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .opacity(opacity)
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                
//                playSound()
                
                withAnimation(getAnimation(0)) {
                    
                    startAnimation.toggle()
                    
                }
                
                withAnimation(getAnimation(0.5)) {
                    
                    boxAnimation.toggle()
                    
                }
                
                withAnimation {
                    startLetters.toggle()
                }
                
                withAnimation(Animation.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(1.7)) {
                    
                    endAnimation.toggle()
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                    withAnimation(Animation.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05)) {
                        
                        endAnimation2.toggle()
                        
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                    withAnimation(exitAni()) {
                        fullEnd.toggle()
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    opacity = 0
                }
                
            }
            
        }
    }
    
    func getAnimation(_ delay: Double)->Animation {
        return Animation.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(delay)
    }
    
    func exitAni()->Animation{
        return Animation.easeInOut(duration: 1.5)
    }
    
    func playSound() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            system.playSucess()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            system.playSucess()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            system.playSucess()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            system.playSucess()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            system.playSound("chime")
        }
    }
}

enum ShapeView {
    case OShape
    case RShape
    case DShape
    case LShape
    case EShape
}

//extension View {
//
//    func getRect()->CGRect{
//        return UIScreen.main.bounds
//    }
//
//    func getSafeArea()->UIEdgeInsets{
//
//        guard let screen =
//            UIApplication.shared.connectedScenes.first as? UIWindowScene else {
//            return .zero
//        }
//
//        guard let safeArea = screen.windows.first?.safeAreaInsets else{
//            return .zero
//        }
//
//        return safeArea
//
//
//    }
//
//}

struct SplashShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid + 80, y: height - 80))
            
            path.addArc(center: CGPoint(x: mid, y: height), radius: 90, startAngle: .init(degrees: 330), endAngle: .init(degrees: 40), clockwise: true)
        }
    }
}

struct SplashBox: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid + 150, y: height - 150))
            path.addLine(to: CGPoint(x: mid - 150, y: height - 150))
            
            path.move(to: CGPoint(x: mid - 150, y: height - 150))
            path.addLine(to: CGPoint(x: mid - 150, y: height + 150))
            
            path.move(to: CGPoint(x: mid - 150, y: height + 150))
            path.addLine(to: CGPoint(x: mid + 150, y: height + 150))
            
            path.move(to: CGPoint(x: mid + 150, y: height + 150))
            path.addLine(to: CGPoint(x: mid + 150, y: height - 150))
        }
    }
}

struct OShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid + 50, y: height - 50))
            
            path.addArc(center: CGPoint(x: mid, y: height), radius: 70, startAngle: .init(degrees: 300), endAngle: .init(degrees: -60), clockwise: true)
        }
    }
}

struct RShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid - 50, y: height - 60))
            path.addLine(to: CGPoint(x: mid - 50, y: height + 60))
            
            path.move(to: CGPoint(x: mid - 50, y: height))
            path.addArc(center: CGPoint(x: mid, y: height - 10), radius: 50, startAngle: .init(degrees: 180), endAngle: .init(degrees: 330), clockwise: false)
        }
    }
}

struct DShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid + 70, y: height))
            
            path.addArc(center: CGPoint(x: mid, y: height), radius: 70, startAngle: .init(degrees: 360), endAngle: .init(degrees: 0), clockwise: true)
            
            path.move(to: CGPoint(x: mid + 70, y: height + 70))
            path.addLine(to: CGPoint(x: mid + 70, y: height - 150))
        }
    }
}

struct LShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid, y: height + 70))
            path.addLine(to: CGPoint(x: mid, y: height - 150))
        }
    }
}

struct EShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
        
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid - 20, y: height))
            
            path.addArc(center: CGPoint(x: mid, y: height), radius: 70, startAngle: .init(degrees: 330), endAngle: .init(degrees: 40), clockwise: true)
        }
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar()
//    }
//}
