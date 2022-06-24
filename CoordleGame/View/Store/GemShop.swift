//
//  GemShop.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/12/22.
//

import SwiftUI
import RevenueCat

struct GemShop: View {
    
    /// - State for displaying an overlay view
    @State private var isPurchasing: Bool = false
    
    /// - The current offering saved from PurchasesDelegateHandler
    @EnvironmentObject var player: PlayerModel
    var offering: Offering?
    
    @State private var error: NSError?
    @State private var displayError: Bool = false
    
    private var dualColumn = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
        
            LazyVGrid(columns: dualColumn, spacing: 10) {
                ForEach(player.offerings?.current?.availablePackages ?? []) { pkg in
                    
                    if pkg.storeProduct.localizedTitle != "All Access" {
                    
                        SingleGem(package: pkg) { (pkg) in
                        
                        isPurchasing = true
                        
                        Purchases.shared.purchase(package: pkg) {
                            (transaction, info, error, userCancelled) in
                                isPurchasing = false
                                
                            
                                if let error = error {
                                    self.error = error as NSError
                                    self.displayError = true
                                }
                            }
                            
                        }
                    }
                        
                }
            }.padding(.horizontal)
            
//        .alert(
//            isPresented: self.$displayError,
//            error: self.error,
//            actions: { _ in
//                Button(role: .cancel,
//                       action: { self.displayError = false },
//                       label: { Text("OK") })
//            },
//            message: { Text($0.recoverySuggestion ?? "Please try again") }
//        )
            
        }
    }
}

struct SingleGem: View {
    
    let package: Package
    let onSelection: (Package) -> Void
    
    var body: some View {
        
        HStack {
            
            VStack(spacing: 2) {
                
                Text(package.storeProduct.localizedTitle)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(package.localizedPriceString)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(2)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.green)
                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                    
                    )
                
            }
            
            Image(package.storeProduct.localizedTitle)
                .resizable()
                .scaledToFit()
                .shadow(color: .black.opacity(0.8), radius: 2, x: 3, y: 3)
            
        }
        .padding(4)
        .padding(.horizontal, 4)
        .frame(width: Global.screenWidth / 2.3, height: Global.screenHeight / 8)
        .background(
        
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.lighterBlue,Color.lightBlue]),
                                   startPoint: .bottomTrailing,
                                   endPoint: .topLeading)
                )
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
            
        )
//        .frame(width: Global.screenWidth / 2.3, height: Global.screenHeight / 8)
        .onTapGesture {
            onSelection(package)
        }
        .padding(.horizontal)
            
    }
}


//struct GemShop_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Spacer()
//            SingleGem()
//            SingleGem()
//            SingleGem()
//        }
//    }
//}

extension NSError: LocalizedError {

    public var errorDescription: String? {
        return self.localizedDescription
    }

}
