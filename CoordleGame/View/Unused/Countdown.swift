////
////  321.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/19/22.
////
//
//import SwiftUI
//
//struct Countdown: View {
//    
//    @State var opacity = 1.0
//    
//    var body: some View {
//        ZStack {
//            
//            Color.black.opacity(0.6)
//
//            CountdownModule(string: "3", delay: 0)
//            CountdownModule(string: "2", delay: 1)
//            CountdownModule(string: "1", delay: 2)
//            CountdownModule(string: "GO", delay: 3, gold: false)
//        }
//        .edgesIgnoringSafeArea(.all)
//        .opacity(opacity)
//        .onAppear {
//            withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5).delay(3.6)) {
//                opacity = 0
//            }
//        }
//    }
//}
//
//struct CountdownModule: View {
//    
//    var color1 = Color(UIColor(red: 41/255, green: 244/255, blue: 153/255, alpha: 1.0))
//    var color2 = Color(UIColor(red: 33/255, green: 189/255, blue: 127/255, alpha: 1.0))
//    
//    @State var begin = false
//    @State var end = false
//    let height = Global.screenHeight / 1.7
//    var string: String
//    var delay: Double
//    var gold = true
//    
//    var body: some View {
//        
//        StrokeText(text: string, width: 2, gradient: gold ? Gradient(colors: [.gold1,.gold3]) : Gradient(colors: [color1,color2]))
//            .font(.system(size: 150, weight: .bold))
//            .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
//            .offset(y: end ? height : (begin ? 0 : -(height)))
//            .onAppear {
//                
//                withAnimation(pullDown(delay)) {
//                    begin.toggle()
//                }
//                
//                withAnimation(pullDown(delay + 0.75)) {
//                    end.toggle()
//                }
//                
//            }
//    }
//    
//    func pullDown(_ del: Double)->Animation {
//        return Animation.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5).delay(del)
//    }
//}
//
//struct StrokeText: View {
//    let text: String
//    let width: CGFloat
//    var gradient: Gradient
//
//    var body: some View {
//        ZStack{
//            ZStack{
//                Text(text).offset(x:  width, y:  width)
//                Text(text).offset(x: -width, y: -width)
//                Text(text).offset(x: -width, y:  width)
//                Text(text).offset(x:  width, y: -width)
//            }
//            .foreground(
//
//                LinearGradient(gradient: gradient,
//                               startPoint: .bottomTrailing, endPoint: .topLeading)
//                
//                .opacity(0.7)
//            )
//            
//            Text(text)
//                .foreground(
//                    
//                    LinearGradient(gradient: gradient,
//                                   startPoint: .topLeading, endPoint: .bottomTrailing)
//
//                )
//        }
//    }
//}
//
//struct _21_Previews: PreviewProvider {
//    static var previews: some View {
//        Countdown()
//    }
//}
