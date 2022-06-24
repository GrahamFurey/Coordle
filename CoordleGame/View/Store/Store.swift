//
//  Store.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/12/22.
//

import SwiftUI

struct Store: View {
    
    @State var currentTab = 0
    @EnvironmentObject var player: PlayerModel
    @EnvironmentObject var system: SystemFunctions
    
    var inView: Bool { system.currentView == 1 }
    
    var body: some View {
            
        VStack(spacing: 0) {
            
            Spacer().overlay(
                CustomSegmentedControl(selected: $currentTab)
                    .padding(.vertical), alignment: .bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
            
                VStack(spacing: 10) {
                    SpecialOffer(inView: inView)
                    AdFor50()
                    GemShop()
                    Spacer().frame(height: Global.screenHeight*0.25)
                }
                
            }
            .frame(width: Global.screenWidth, height: Global.screenHeight*0.8)
            .overlay(
                Rectangle()
                    .fill(Color.background)
                    .frame(height: 100)
                    .frame(maxHeight: .infinity,alignment: .bottom)
            )
            .ignoresSafeArea(.container, edges: .vertical)
            .overlay(
                VStack {
                    HStack(spacing: 8) {
                        GemForPrize()
                        AdForGem(amt: Int.random(in: 50...99))
                    }
                    .padding(.horizontal)
                
                Button(action: {
                    system.showVIP.toggle()
                }) {
                    TicketPreview(inView: inView)
                    
                }
                    .buttonStyle(AdvancedButtonStyle())
                }
                    .background(MaskGroup(h: 80), alignment: .top)
                    .padding(.bottom,40)
//                    .overlay(
//                        ZStack {
//                            HStack(spacing: 8) {
//                                GemForPrize()
//                                AdForGem(amt: Int.random(in: 50...99))
//                            }
//                            .padding(.horizontal)
//                        }
//                        .opacity(inView ? 1 : 0)
//                        , alignment: .top
//                    )
                , alignment: .bottom
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .edgesIgnoringSafeArea(.all)
    }

}

struct MaskGroup: View {
    var h: CGFloat = 50
    var body: some View {
        Color.background
          .mask(
            VStack(spacing: 0) {
              LinearGradient(
                stops: [
                  Gradient.Stop(color: .clear, location: .zero),
                  Gradient.Stop(color: .black, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
              )
              .frame(height: h)
              Color.black
            }
          )
          .padding(.top, -55)
//          .opacity(selectedTab == 0 ? 1.0 : 0)
          .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct CustomSegmentedControl: View {
    @Binding var selected: Int
    @Namespace var animation
    let ani = Animation.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)
    var body: some View {
        
        HStack {
            
            Button(action: { withAnimation(ani){ selected = 0 } }) {
                Image("Jewels")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(
                        ZStack {
                            if selected == 0 {
                                Color.white
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 0 ? .lightBlue : .gray)
                
            Button(action: { withAnimation(ani){ selected = 1 } }) {
                Image("Characters")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(
                        ZStack {
                            if selected == 1 {
                                Color.white
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 1 ? .lightBlue : .gray)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 8)
        .background(Color.darkShadow)
        .clipShape(Capsule())
        
    }
}
