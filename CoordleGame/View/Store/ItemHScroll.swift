//
//  ItemHScroll.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/28/22.
//
//
import SwiftUI
import Combine

struct ItemScroll: View {
    @StateObject var scrollViewHelper = ScrollViewHelper()
    @Binding var level: Int
    @Binding var selected: Int
    @Binding var isMoving: Bool
    var items: [Item]
    var h = Global.screenWidth * 0.22

    var body: some View {

        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(items) { item in
                        let s = selected == item.id ? 1.2 : 1.0
                        
                        ItemView(item: item)
                            .frame(width: h*s, height: h*s)
                            .id(item.id)
                            .padding(.horizontal,6*s)
                    }
                }
                .background(ScrollBackground())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onChange(of: level) { i in
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.2)) {
                        if i == 0 { reader.scrollTo(0) }
                        if i == 1 { reader.scrollTo(17) }
                        if i == 2 { reader.scrollTo(29) }
                        if i == 3 { reader.scrollTo(40) }
                    }
                }
            }.coordinateSpace(name: "scroll")
            .onPreferenceChange(ViewOffsetKey.self) {
                scrollViewHelper.currentOffset = getIdPos($0)
                isMoving = true
            }
            .onReceive(scrollViewHelper.$offsetAtScrollEnd) {
                var x = $0.whole
                if $0.fraction >= 0.5 { x += 1 }
                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.2)) {
                    selected = Int(x)
                    reader.scrollTo(selected)
                    changeTabBar(selected)
                    isMoving = false
                }
            }
        }
        
    }
    
    func getIdPos(_ d: Double)->Double {
        return (d + 1.8*h)/(1.2*h)
    }
    
    func changeTabBar(_ i: Int) {
        if i < 17 && i >= 0  { level = 0 }
        if i < 29 && i >= 17 { level = 1 }
        if i < 40 && i >= 29 { level = 2 }
        if i < 45 && i >= 40 { level = 3 }
    }
}

struct ScrollBackground: View {
    let fgs = [Color.giftGreen2, .giftBlue2, .giftPurp2, .giftYellow2]
    let bgs = [Color.giftGreen1,.giftBlue1,.giftPurp1,.giftYellow1]
    let stops = [0.378, 0.644,0.889]
    
    var body: some View {
        ZStack {
            GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).minX)
            }
            .padding(.horizontal,15)
            
            ForEach(0..<4) { i in
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.clear, location: 0),
                                                          Gradient.Stop(color: bgs[i], location: stops[i]),
                                                          Gradient.Stop(color: fgs[i], location: 1.0)]),
                               startPoint: .leading, endPoint: .trailing)
            }
            .opacity(0.7)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.vertical,8)
            .padding(.horizontal,8)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.giftGreen1,lineWidth: 10)
                .opacity(0.8)
        }
    }
}

class ScrollViewHelper: ObservableObject {
    
    @Published var currentOffset: CGFloat = 0
    @Published var offsetAtScrollEnd: CGFloat = 0
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = AnyCancellable($currentOffset
                                        .debounce(for: 0.2, scheduler: DispatchQueue.main)
                                        .dropFirst()
                                        .assign(to: \.offsetAtScrollEnd, on: self))
    }
    
}


struct ViewOffsetKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

//
//struct value {
//    var float: CGFloat
//    var pos: Alignment
//}
//
//struct ItemHScroll: View {
//    @State var currentOffset = 0.0
//    @State var selected: Int = -1
//    @State var items: [Item] = storeItems
//    var h = Global.screenWidth * 0.22
//    @Binding var selection: Int
//
//    @State var currentChoice = 1
//    //mf max 375, min 47
//    //geo max 116,224,332,440
//    //
//
//    var body: some View {
//        GeometryReader { mainView in
//            HStack(spacing: 12) {
//                ForEach(items) { item in
//                    GeometryReader { geo in
//
//                        let val = scaleVal(mainView.frame(in: .global), geo.frame(in: .global))
//
//                        ItemView(img: item.img, color: item.color, unlocked: !item.unlocked)
//                            .frame(width: h*val, height: h)
//                            .background(
//                                    ZStack {
//
//                                        SelectionBox()
//                                            .frame(width: h*1.15, height: h*1.62)
//                                            .modifier(AddShadow(cr: 8, color: .darkShadow, offsetX: -2, offsetY: 3))
//                                            .overlay (
//
//                                                Button(action: { withAnimation(.spring()) { selection = item.id}}) {
//                                                    ZStack {
//                                                        //switch
//                                                        if !item.unlocked {
//                                                            UseButton(width: h)
//                                                            UseButton(text: "SET", color1: .lighterBlue, color2: .lightBlue, width: h)
//                                                                .opacity(selection == item.id ? 1 : 0)
//
//                                                        } else {
//                                                            LockButton(width: 40)
//                                                        }
//                                                    }.padding(.bottom,3)
//                                                }
//                                                .buttonStyle(AdvancedButtonStyle())
//                                                .disabled(item.unlocked)
//                                                //switch
//                                                , alignment: .bottom
//                                            )
//                                }
//                                .padding(.top,25)
//                                .opacity(selected == item.id ? 1 : 0)
//                            )
//                            .onTapGesture {
//                                withAnimation(.spring()) { selected = item.id }
//                            }
//                    }
//                    .frame(width: h, height: h)
//                }
//            }
//            .padding(.horizontal,15)
//            .offset(x: currentOffset)
//            .gesture(
//                DragGesture()
//                    .onChanged({ val in
//                        let wd = val.translation.width
//
////                        let wid = mainView.size.width
////                        let max = min(((wd/h)*2), wid)
//
//                         currentOffset += (wd/h)*2
//                    })
//                    .onEnded({ w in
//                        let z = w.translation.width
//                        let max = h*0.1
//                        if z < 0 {
//                            if z < -max {
//                                currentOffset = -max
//                            }
//                        } else {
//                            if z/h > CGFloat(items.count) {
//                                currentOffset = max
//                            }
//                        }
//
////                        let max = h*0.5
////                        withAnimation {
////                            if currentOffset > h*CGFloat(items.count) + h {
////                                currentOffset = min(currentOffset*h, max)
////                            }
////
////                            if currentOffset < 0 {
////                                currentOffset = -(min(abs(currentOffset*h), max))
////                            }
////                        }
//                    })
//////
//////                        let c = (valw/h)/(mainView.size.width)
//////                        let whole = Int(c.whole)
//////                        withAnimation {
//////                            if c.fraction >= 0.5 {
//////                                currentOffset = Double(whole + 1)
//////                            } else {
//////                                currentOffset = Double(whole)
//////                            }
//////
//////                            currentChoice = currentOffset >= 0 ? Int(currentOffset + 1) : 0
//////                        }
//
//            )
//        }
//    }
//
//    func scaleVal(_ mainFrame: CGRect, _ local: CGRect)->CGFloat {
//        withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 0.4, blendDuration: 0.8)) {
//            let scale = mainFrame.maxX*0.5 / (local.maxX*0.55)
//            let scale2 = mainFrame.maxX*0.7 / ((-local.minX + mainFrame.maxX)*0.65)
////            mainFrame.maxX / (mainFrame.maxX - local.maxX*1.1)
//
//
//            if abs(scale2) > 1 {
//                if abs(scale) > 1 {
//                    return 1
//                } else {
//                    return scale
//                }
//            } else {
//                return scale2
//            }
//        }
//    }
//}
//

//struct ItemSnapScroller: View {
//
//    @State var items: [Item] = storeItems
//    var h = Global.screenWidth * 0.22
//    @State var selection: Int = 0
//
//    var body: some View {
//
//        ForEach(items.reversed()) { item in
//            HStack {
//                ItemView(img: item.img, color: item.color, unlocked: !item.unlocked)
//                    .frame(width: h)
//            }
//        }
//
//    }
//}
//
//
//
//struct ItemScroller_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemSnapScroller()
//    }
//}

