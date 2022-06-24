//
//  5StarView.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/2/22.
//

import SwiftUI
import StoreKit

struct _StarView: View {
    var body: some View {
        
        VStack {
            Button(action: {review()}) {
                Text("Review")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 280, height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blackText)
                    )
            }.buttonStyle(AdvancedButtonStyle())
            
            Button(action: {}) {
                HStack(spacing: 3) {
                    Text("Refer A Friend")
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
            }.buttonStyle(AdvancedButtonStyle())
        }
    }
    
    func review() {
        if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
    }
}

struct _StarView_Previews: PreviewProvider {
    static var previews: some View {
        _StarView()
    }
}
