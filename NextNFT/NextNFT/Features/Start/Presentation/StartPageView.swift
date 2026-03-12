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
            AppColors.darkBackground
                .ignoresSafeArea(edges: [.top, .bottom])
            VStack(spacing: 0) {
                Image("startPage")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(edges: [.top])
                
                Spacer()
                
                VStack {
                    Text("Log in to see all your NFTs")
                    
                    Text("Easily buy and sell NFTs in a secure, user-friendly marketplace - all in one place")
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Button("G") {
                            // Google action
                        }
                        
                        Button("f") {
                            // Facebook action
                        }
                        
                        Button("Start experience") {
                            // Start experience action
                        }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                        
                        Button("Log in") {
                            // Login action
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StartPageView()
}
