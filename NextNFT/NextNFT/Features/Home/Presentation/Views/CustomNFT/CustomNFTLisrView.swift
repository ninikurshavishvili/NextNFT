//
//  CustomNFTLisrView.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 28.01.26.
//

import SwiftUI

import SwiftUI

struct NFTCarouselView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            HStack {
                Text("Create a custom ")
                    .foregroundColor(.white)
                + Text("NFT")
                    .foregroundColor(.blue)
                + Text(" Marketplace for your community")
                    .foregroundColor(.white)

                Spacer()

                Button {
                    // action later
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .font(.title3.weight(.semibold))
            .padding(.horizontal)

            // Horizontal Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {

                    // Repeat cards
                    CustomNFTCardView()
                    CustomNFTCardView()
                    CustomNFTCardView()
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
        }
    }
}


#Preview {
    NFTCarouselView()
}
