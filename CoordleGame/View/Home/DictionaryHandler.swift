//
//  DictionaryHandler.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/2/22.
//

import SwiftUI

struct DictionaryHandler: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
        
            VStack(spacing: 0) {
                
                Spacer()
                
                Image(systemName: "xmark.octagon")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top,30)
                
                
                Spacer()
                
                VStack(spacing: 10) {
                
                    Text("No Language Support")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.blackText)
                    
                    VStack(spacing: 2) {
                        
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("Please install the")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.blackText)
                            
                            Text("English (US)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(3)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.blackText)
                                )
                        }
                        
                        Text("dictionary to continue playing.")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blackText)
                    }
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("Settings")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.blackText)
                        Text(" > ")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.blackText)
                        Text("General")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.blackText)
                        Text(" > ")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.blackText)
                        Text("Dictionary")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.blackText)
                        
                    }
                    .padding(.bottom)
                    
                }
                .padding(.vertical)
                
                
                Spacer()
            }
            .frame(width: 280, height: 240)
            .background(
                LinearGradient(gradient:
                                Gradient(stops: [Gradient.Stop(color: Color.red, location: 0),Gradient.Stop(color: Color.red, location: 0.43),Gradient.Stop(color: Color.white, location: 0.43),Gradient.Stop(color: Color.white, location: 1.0)]),
                               startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(15)
            .overlay(
                Button(action: {isPresented.toggle()}) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(7)
                        .background(
                            Circle()
                                .fill(Color.blackText)
                        )
                }
                .buttonStyle(AdvancedButtonStyle())
                .offset(x: 7, y: -7)
                , alignment: .topTrailing
            )
            .padding(.top,30)
            
            Button(action: {openSettings()}) {
                HStack(spacing: 3) {
                    Text("Settings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: 280, height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blackText)
                )
            }
            .buttonStyle(AdvancedButtonStyle())
            
        }
        .offset(y: isPresented ? 0 : Global.screenHeight)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.black.opacity(isPresented ? 0.6 : 0)
                .onTapGesture {
                    isPresented.toggle()
                }
        )
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}


struct aef: PreviewProvider {
    static var previews: some View {
        DictionaryHandler(isPresented: .constant(true))
    }
}
   
