//
//  Untitled.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 14.02.26.
//

import SwiftUI

struct SkeletonCollectionCardView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.gray.opacity(0.3))
            
            // Gradient overlay
            LinearGradient(
                colors: [.black.opacity(0.6), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .cornerRadius(28)
            
            // Content placeholder
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    // Title placeholder
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 120, height: 20)
                    
                    // Subtitle placeholder
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 80, height: 16)
                }
                
                Spacer()
                
                // Buttons placeholder
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.25))
                        .frame(width: 100, height: 36)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 120, height: 36)
                }
            }
            .padding()
        }
        .frame(width: 260, height: 340)
        .cornerRadius(28)
        .overlay(
            // Shimmer effect
            GeometryReader { geometry in
                Color.white
                    .opacity(0.2)
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .white.opacity(0.5), .clear]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .rotationEffect(.degrees(30))
                            .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 28))
        )
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
    }
}
