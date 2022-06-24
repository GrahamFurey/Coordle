//
//  Leaderboard.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/17/22.
//

import SwiftUI

struct Leaderboard: View {
    
    @EnvironmentObject var player: PlayerModel
    @EnvironmentObject var data: DataModel
    
    @Binding var selectedTab: Int
    @State var currentType: String = "Most XP"
    @Namespace var animation
    @State var rankings: [Rank] = []
    
    @State var headerOffsets: (CGFloat,CGFloat) = (0,0)
    @State var beginAnimation = false
    @State var beginRankAnimation = false
    
    var body: some View {
        ZStack{
            
            Color.background
            
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        HeaderView()
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section {
                                Rankings()
                            } header: {
                                PinnedHeaderView()
                                    .background(Color.background)
                                    .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                                    .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                                    .modifier(OffsetModifier(offset: $headerOffsets.1))
                            }
                        }
                        
                    }
                }.overlay(
                    Rectangle()
                        .fill(Color.background)
                        .frame(height: 100)
                        .frame(maxHeight: .infinity,alignment: .bottom)
                )
                .ignoresSafeArea(.container, edges: .vertical)
                .overlay(
                    YourRank()
                        .padding(.horizontal,5)
                    , alignment: .bottom
                )
                .overlay(
                    Rectangle()
                        .fill(Color.background)
                        .frame(height: 100)
                        .frame(maxHeight: .infinity,alignment: .top)
                        .opacity(headerOffsets.0 < 5 ? 1 : 0)
                )
                .coordinateSpace(name: "SCROLL")
                .ignoresSafeArea(.container, edges: .vertical)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            for i in 0..<1000 { rankings.append(Rank(i)) }
        }
        .onChange(of: selectedTab) { val in
            var isInView: Bool { val == 2 }
            beginAnimation = isInView
            withAnimation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.6)) {
                beginRankAnimation = isInView
            }
        }
    }
    
    @ViewBuilder
    func HeaderView()->some View {
        
        GeometryReader{proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            let diff = height/size.height
            
            
            LinearGradient(colors: [Color.darkPurple1,Color.darkPurple2],
                           startPoint: .top,
                           endPoint: .bottom)
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(
                    VStack {
                        
                        TextStats()
                            .frame(height: height*0.33)
                            .padding(.horizontal, 40)
                            .scaleEffect(diff > 1.1 ? 1.1 : diff)
                    
                        Image("standingsEq")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: height*0.33)
                            .offset(y: beginAnimation ? 0 : 150)
                            .animation(Animation.easeInOut(duration: 0.5))
                        
                    }
                    .offset(y: height*0.07)
                    .background(
                    
                        ZStack {
                        
                            Circle()
                                .fill(
                                
                                    LinearGradient(colors: [Color.lightPurple1,Color.lightPurple2], startPoint: .leading, endPoint: .trailing)
                                    
                                )
                                .scaleEffect(beginAnimation ? 1 : 0.3)
                                .opacity(beginAnimation ? 1 : 0.3)
                            
                            Circle()
                                .stroke(LinearGradient(colors: [.lightPurple1,.lightPurple2], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                                .scaleEffect(beginAnimation ? 1.5 : 0.3)
                                .opacity(beginAnimation ? 0.7 : 0.3)
                            
                            Circle()
                                .stroke(LinearGradient(colors: [.lightPurple1,.lightPurple2], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                                .scaleEffect(beginAnimation ? 2.0 : 0.3)
                                .opacity(beginAnimation ? 0.5 : 0.3)
                            
                            
                        }.animation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.2).delay(0.3))
                        .offset(y: height*0.25)
                    
                    )
                    , alignment: .bottom
                )
                
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: 300)
    }
    
    @ViewBuilder
    func Rankings()->some View {
        LazyVStack(spacing: 10) {
            
            ForEach(rankings) { rank in
                
                PlayerRankView(rank: rank)
                    .opacity(beginRankAnimation ? 1 : 0)
                    .rotation3DEffect(.degrees(beginRankAnimation ? 0 : 180), axis: (x: 1, y: 0, z: 0))
//                    .delay(Double(rank.rank)*0.2))
                    
                }
            
                PlayerRankView(rank: Rank(0))
                    .opacity(0)
                PlayerRankView(rank: Rank(0))
                    .opacity(0)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 30)
            
        }
    
//    func getIndex(rank: Rank)->Int{
//        return rankings.firstIndex { current in
//            return rank.id == current.id
//        } ?? 0
//    }
    
    @ViewBuilder
    func PinnedHeaderView()->some View {
        let types: [String] = ["Most XP", "Fastest", "Max Streak", "Wins"]
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 25) {
                
                ForEach(types, id: \.self) { type in
                    
                    VStack(spacing: 12) {
                        Text(type)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .black : .gray)

                        
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TYPE", in: animation)
                                
                            } else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(Color.clear)
                            }
                        }
                        .padding(.horizontal, 4)
                        .frame(height: 4)
                    
                    }.contentShape(RoundedRectangle(cornerRadius: 4))
                    .onTapGesture {
                        withAnimation(Animation.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentType = type
                        }
                    }
                        
                }
            }.padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom,5)
            
        }
    }
    
    @ViewBuilder func YourRank()->some View {
        Button(action: {
            selectedTab = 4
        }) {
            PlayerRankView(rank: Rank(rank: data.rank, username: "YOU", pfp: "partyFace", cc: "US", score: data.points, badge: "badge5"), seondaryColor: .white.opacity(0.7), usernmcolor: .white)
                .padding(.horizontal)
            .padding(.vertical,12)
                
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.rain1,Color.rain2, Color.rain3,Color.rain4]), startPoint: .leading, endPoint: .trailing)
                        .cornerRadius(20, corners: [.topLeft,.bottomRight])
                )
                .padding(.horizontal)
            
        }
            .buttonStyle(AdvancedButtonStyle())
            .background(MaskGroup(), alignment: .top)
            .padding(.bottom,40)
    }
}

struct TextStats: View {
    
    @State var beginAnimation = false
    
    let color1 = Color(UIColor(red: 250/255, green: 213/255, blue: 109/255, alpha: 1.0))
    let color2 = Color(UIColor(red: 247/255, green: 125/255, blue: 48/255, alpha: 1.0))
    
    let color3 = Color(UIColor(red: 117/255, green: 246/255, blue: 193/255, alpha: 1.0))
    let color4 = Color(UIColor(red: 82/255, green: 192/255, blue: 222/255, alpha: 1.0))
    
    let color5 = Color(UIColor(red: 238/255, green: 89/255, blue: 155/255, alpha: 1.0))
    let color6 = Color(UIColor(red: 238/255, green: 18/255, blue: 114/255, alpha: 1.0))
    
    var body: some View {
        
        HStack(spacing: 40) {
            
            Spacer().overlay(
            
            VStack(spacing: 2) {
                
                Text("Games \nPlayed")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize()
                
                Text("54")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(.white)
                    .fixedSize()
                
            }
            .padding(10)
            .padding(.horizontal, 10)
            .background(
                
                ZStack {
                
                    RoundedRectangle(cornerRadius: 20)
                        .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: .leading, endPoint: .trailing))
                    
                }
            )
            .offset(y: beginAnimation ? -10 : 200)
            .animation(returnAnimation(delay: 0.3))
            )
            
            
            VStack(spacing: 2) {
                
                Text("Max\nStreak")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize()
                
                Text("32")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(.white)
                    .fixedSize()
                
            }
            .padding(10)
            .padding(.horizontal, 10)
            .background(
                
                ZStack {
                
                    RoundedRectangle(cornerRadius: 20)
                        .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [color3,color4]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                }
            )
            .offset(y: -15)
            .offset(y: beginAnimation ? -10 : 200)
            .animation(returnAnimation(delay: 0.5))
            
            Spacer().overlay(
            VStack(spacing: 2) {
                
                Text("Total\nWins")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize()
                
                Text("91")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(.white)
                    .fixedSize()
                
            }
            .padding(10)
            .padding(.horizontal, 12)
            .background(
                
                ZStack {
                
                    RoundedRectangle(cornerRadius: 20)
                        .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [color5,color6.opacity(0.9)]), startPoint: .trailing, endPoint: .leading))
                    
                }
            )
            )
            .offset(y: beginAnimation ? -10 : 200)
            .animation(returnAnimation(delay: 0.4))
            
        }.onAppear {
            withAnimation {
                beginAnimation.toggle()
            }
        }
        
    }
    
    func returnAnimation(delay: Double)->Animation{
        return Animation.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.5).delay(delay)
    }
    
}
