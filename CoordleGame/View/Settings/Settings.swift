//
//  Settings.swift
//  CoordleGame
//
//  Created by Graham Furey on 3/31/22.
//

import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var system: SystemFunctions
    
    var body: some View {
        
        ZStack(alignment: .top) {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                    VStack {
                    
                        AudioSwitch(isOn: system.$soundOn)
                    
                        HapticSwitch(isOn: system.$hapticsOn)
                        
                    }
                
                Divider()
                
                VStack {
                    
                    ChangeUsername()
                    
                    RestoreButton()
                        .onTapGesture {
                            print("restore products")
                        }
                    
                }
                    
                    Divider()
                    
                    VStack {
                    
                    TwitterButton()
                    
                    InstaButton()
                        
                    }
                
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.horizontal)
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                Text("Settings")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
            }.padding()
            .padding(.leading)
        }
        
    }
}

struct ConteView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

struct HapticSwitch: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        Button(action: { isOn.toggle() }) {
        
            HStack {
                
                Text("\(isOn ? "Disable" : "Enable") Haptics")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("vibrate")
                    .resizable()
                    .scaledToFill()
                    .colorInvert()
                    .opacity(isOn ? 1 : 0.5)
                    .frame(maxWidth: 30)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(Color.purple)
            )
            .frame(maxHeight: 60)
            
        }
    }
}

struct AudioSwitch: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        Button(action: { isOn.toggle() }) {
        
            HStack {
                
                Text("\(isOn ? "Disable" : "Enable") Audio")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(isOn ? "audio" : "noAudio")
                    .resizable()
                    .scaledToFill()
                    .colorInvert()
                    .opacity(isOn ? 1 : 0.5)
                    .frame(maxWidth: 30)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(Color.purple)
            )
            .frame(maxHeight: 60)
            
        }
        
    }
}
//
//struct DarkModeSwitch: View {
//
//    @Binding var isDark: Bool
//
//    var body: some View {
//
//        Button(action: { isDark.toggle() }) {
//
//            HStack {
//
//                Toggle(isOn: $isDark) {
//
//                    Text("\(isDark ? "Disable" : "Enable") Dark Mode")
//                        .font(.system(size: 20))
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//                .toggleStyle(DarkModeToggle())
//
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .padding(.horizontal)
//            .background(
//                Capsule()
//                    .fill(Color.purple)
//            )
//            .frame(maxHeight: 60)
//
//        }
//
//    }
//
//}

struct ChangeNumber: View {
    
    var body: some View {

        Button(action: {}) {
        
        Text("string")
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(Color.purple)
            )
            .frame(maxHeight: 60)
            
        }
        
    }
}

struct RestoreButton: View {
    
    var body: some View {
        
        Text("Restore Purchases")
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(Color.purple)
            )
            .frame(maxHeight: 60)
        
    }
    
}

struct ChangeUsername: View {
    
    let gradient = LinearGradient(
                        gradient: .init(colors: [.red, .yellow]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
    
    var body: some View {

        Button(action: {}) {
        
            HStack(spacing: 0) {
                
                
                Text("Change @")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                
                
                Text("username")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foreground(gradient)
                
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(Color.purple)
            )
            .frame(maxHeight: 60)
            
        }
        
    }
    
}

extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        self.overlay(overlay).mask(self)
    }
}

struct TwitterButton: View {
    
    let lightBlue = Color(UIColor.init(red: 0/255, green: 163/255, blue: 244/255, alpha: 1.0))
    
    var body: some View {
        HStack {
        
                Text("Follow me on Twitter")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Image("twitter")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 30)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal)
        .background(
            Capsule().fill(lightBlue)
        )
        .frame(maxHeight: 60)
    }
}

struct InstaButton: View {
    
    let color1 = Color(UIColor.init(red: 79/255, green: 91/255, blue: 213/255, alpha: 1.0))
    let color2 = Color(UIColor.init(red: 150/255, green: 47/255, blue: 191/255, alpha: 1.0))
    let color3 = Color(UIColor.init(red: 214/255, green: 41/255, blue: 118/255, alpha: 1.0))
    let color4 = Color(UIColor.init(red: 250/255, green: 126/255, blue: 30/255, alpha: 1.0))
    let color5 = Color(UIColor.init(red: 254/255, green: 218/255, blue: 117/255, alpha: 1.0))
    
    var instaGradient = LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    init() {
        instaGradient = LinearGradient(gradient: Gradient(colors: [color1, color2, color3, color4, color5]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        
        HStack {
            
            Text("Follow me on IG")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Image("instagram")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 30)
            
        }
        .frame(maxWidth: .infinity).padding()
        .padding(.horizontal)
        .background(
            Capsule()
                .fill(instaGradient)
        )
        .frame(maxHeight: 60)
        
    }
}
