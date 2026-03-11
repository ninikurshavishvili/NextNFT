//
//  StartPageView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 10.03.26.
//

import SwiftUI


struct StartPageView: View {
    var body: some View {
        ZStack {

            
            VStack(spacing: 30) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.purple, .pink]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 120, height: 120)
                        .offset(x: -40, y: -30)
                    
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue, .cyan]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 100, height: 100)
                        .offset(x: 50, y: 20)
                    
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.orange, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 80, height: 80)
                        .offset(x: -20, y: 60)
                    
                    // Grid pattern (NFT icons representation)
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white.opacity(0.2))
                }
                .frame(height: 200)
                
                // Title
                Text("Log in to see all your NFTs")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Subtitle
                Text("Easily buy and sell NFTs in a secure, user-friendly marketplace - all in one place")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                // Social Login Buttons
                HStack(spacing: 20) {
                    socialLoginButton(icon: "g.circle.fill", color: .blue, text: "G")
                    
                    // Facebook button
                    socialLoginButton(icon: "f.circle.fill", color: .blue, text: "f")
                }
                .padding(.top, 30)
                
                Button(action: {

                }) {
                    HStack {
                        Text("Start experience")
                            .fontWeight(.semibold)
                        Text("7")
                            .font(.caption)
                            .padding(6)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                Spacer()
                
                // Already have an account link
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Log in") {
                        // Action for login
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                }
                .padding(.bottom, 30)
                .background(AppColors.darkBackground)
            }
        }
    }
    
    @ViewBuilder
    func socialLoginButton(icon: String, color: Color, text: String) -> some View {
        Button(action: {
            // Social login action
        }) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    .frame(width: 60, height: 60)
                
                if text == "G" {
                    // Google G
                    Text("G")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                } else {
                    // Facebook f
                    Text("f")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    StartPageView()
}
