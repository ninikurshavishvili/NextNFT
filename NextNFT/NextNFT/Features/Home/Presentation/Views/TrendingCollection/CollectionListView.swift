//
//  CollectionListView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 28.07.25.
//

import SwiftUI

struct CollectionListView: View {
    /// Loaded with the collection by `GetTrendingCollectionsUseCase`.
    let nfts: [NFT]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(nfts) { nft in
                    CollectionCardView(nft: nft)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 2)
    }
}
#Preview {
    CollectionListView(nfts: [])
        .background(AppColors.darkBackground)
}

