//
//  NFTItemListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 21.07.25.
//

import SwiftUI

struct NFTItemListView: View {
    var title: String = "Latest Drops"
    var SeeAll: String = "See all"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title
            HStack(alignment: .center, spacing: 130) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                Text(SeeAll)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding(.horizontal)
                    .foregroundStyle(.white)
            }
            // Horizontal Scrollable List
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<10) { index in
                        NFTItemCardView()
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    NFTItemListView()
}
